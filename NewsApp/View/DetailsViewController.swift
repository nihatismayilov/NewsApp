//
//  DetailsViewController.swift
//  NewsApp
//
//  Created by Nihad Ismayilov on 30.03.22.
//

import UIKit
import SDWebImage
import DropDown
import SafariServices

class DetailsViewController: UIViewController {
    
    var mediaAPI: String?
    var topicAPI: String?
    var titleAPI: String?
    var authorAPI: String?
    var excerptAPI: String?
    var summaryAPI: String?
    var linkAPI: String?
    var twitterAPI: String?
    var dateAPI: String?
    var from: String?

    @IBOutlet var detailsImageView: UIImageView!
    @IBOutlet var containerView: UIView!
    @IBOutlet var backButton: UILabel!
    @IBOutlet var backButtonView: UIView!
    
    
    @IBOutlet var dropDownView: UIView!
    @IBOutlet var dropDownButton: UIButton!
    let dropDown = DropDown()
    
    //
    let menu: DropDown = {
        let menu = DropDown()
        menu.dataSource = ["Save", "Share"]
        
        return menu
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkData()
        // Corner radius settings
        backButtonView.layer.cornerRadius = 16
        containerView.layer.cornerRadius = 32
        containerView.clipsToBounds = true
        containerView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        self.navigationController?.isNavigationBarHidden = true
        
        // DropDown Settings
        dropDownView.layer.cornerRadius = 14
        menu.cornerRadius = 16
        menu.anchorView = dropDownView
        
        menu.selectionAction = { index, title in
            if index == 0 {
                self.saveButtonClicked()
                if self.menu.dataSource[0] == "Save" {
                    self.menu.dataSource[0] = "Un-Save"
                } else if self.menu.dataSource[0] == "Un-Save" {
                    self.menu.dataSource[0] = "Save"
                }
            } else {
                self.shareButtonClicked()
            }

            print("index \(index) and \(title)")
        }
        
        
        // Back Button Settings
        backButton.text = titleAPI!
        
        // More Button Settings
    }
    
    @IBAction func backButtonClicked(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    override func viewWillAppear(_ animated: Bool) {
        checkData()
        NotificationCenter.default.addObserver(self, selector: #selector(checkData), name: NSNotification.Name("NewData"), object: nil)
    }
    
    @IBAction func dropDownClicked(_ sender: Any) {
        checkData()
        menu.show()
    }
    
    // Soon will be useful
    @objc func checkData() {
        if Helper.sharedInstance.newsTitleArray?.contains(titleAPI ?? "") ?? false {
            self.menu.dataSource[0] = "Un-Save"
        }else {
            self.menu.dataSource[0] = "Save"
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toChild" {
            let destinationVC = segue.destination as! ChildViewController
            detailsImageView.sd_setImage(with: URL(string: mediaAPI ?? "select"))
            destinationVC.topicText = topicAPI
            destinationVC.titleText = titleAPI
            destinationVC.authorText = authorAPI
            destinationVC.excerptText = excerptAPI
            destinationVC.summaryText = summaryAPI
            destinationVC.linkText = linkAPI
            destinationVC.twitterText = twitterAPI
        }
    }
    
    func shareButtonClicked() {
        let activityController = UIActivityViewController(activityItems: [linkAPI!], applicationActivities: nil)
        present(activityController, animated: true)
    }
    
    func saveButtonClicked() {
        
        guard let mediaApi = mediaAPI else { return }
        guard let topicApi = topicAPI else { return }
        guard let titleApi = titleAPI else { return }
        guard let authorApi = authorAPI else { return }
        guard let twittedAccountApi = twitterAPI else { return }
        guard let excerptApi = excerptAPI else { return }
        guard let summaryApi = summaryAPI else { return }
        guard let linkApi = linkAPI else { return }
        guard let dateApi = dateAPI else { return }
        
        if Helper.sharedInstance.newsTitleArray?.contains(titleAPI!) ?? false {
            
            if let mediaIndex = Helper.sharedInstance.newsMediaArray?.firstIndex(of: mediaApi) {
                Helper.sharedInstance.newsMediaArray?.remove(at: mediaIndex)
            }
            if let topicIndex = Helper.sharedInstance.newsTopicArray?.firstIndex(of: topicApi) {
                Helper.sharedInstance.newsTopicArray?.remove(at: topicIndex)
            }
            if let titleIndex = Helper.sharedInstance.newsTitleArray?.firstIndex(of: titleApi) {
                Helper.sharedInstance.newsTitleArray?.remove(at: titleIndex)
            }
            if let authorIndex = Helper.sharedInstance.newsAuthorArray?.firstIndex(of: authorApi) {
                Helper.sharedInstance.newsAuthorArray?.remove(at: authorIndex)
            }
            if let twitterAccountIndex = Helper.sharedInstance.newsTwitterAccountArray?.firstIndex(of: twittedAccountApi) {
                Helper.sharedInstance.newsTwitterAccountArray?.remove(at: twitterAccountIndex)
            }
            if let excerptIndex = Helper.sharedInstance.newsExcerptArray?.firstIndex(of: excerptApi) {
                Helper.sharedInstance.newsExcerptArray?.remove(at: excerptIndex)
            }
            if let summaryIndex = Helper.sharedInstance.newsSummaryArray?.firstIndex(of: summaryApi) {
                Helper.sharedInstance.newsSummaryArray?.remove(at: summaryIndex)
            }
            if let linkIndex = Helper.sharedInstance.newsLinkArray?.firstIndex(of: linkApi) {
                Helper.sharedInstance.newsLinkArray?.remove(at: linkIndex)
            }
            if let dateIndex = Helper.sharedInstance.newsDateArray?.firstIndex(of: dateApi) {
                Helper.sharedInstance.newsDateArray?.remove(at: dateIndex)
            }

        }else {

            Helper.sharedInstance.newsMediaArray?.append(mediaApi)
            Helper.sharedInstance.newsTopicArray?.append(topicApi)
            Helper.sharedInstance.newsTitleArray?.append(titleApi)
            Helper.sharedInstance.newsAuthorArray?.append(authorApi)
            Helper.sharedInstance.newsTwitterAccountArray?.append(twittedAccountApi)
            Helper.sharedInstance.newsExcerptArray?.append(excerptApi)
            Helper.sharedInstance.newsSummaryArray?.append(summaryApi)
            Helper.sharedInstance.newsLinkArray?.append(linkApi)
            Helper.sharedInstance.newsDateArray?.append(dateApi)

        }

        UserDefaults.standard.set(Helper.sharedInstance.newsMediaArray, forKey: "mediaDefaults")
        UserDefaults.standard.set(Helper.sharedInstance.newsTopicArray, forKey: "topicDefaults")
        UserDefaults.standard.set(Helper.sharedInstance.newsTitleArray, forKey: "titleDefaults")
        UserDefaults.standard.set(Helper.sharedInstance.newsAuthorArray, forKey: "authorDefaults")
        UserDefaults.standard.set(Helper.sharedInstance.newsTwitterAccountArray, forKey: "twitterAccountDefaults")
        UserDefaults.standard.set(Helper.sharedInstance.newsExcerptArray, forKey: "excerptDefaults")
        UserDefaults.standard.set(Helper.sharedInstance.newsSummaryArray, forKey: "summaryDefaults")
        UserDefaults.standard.set(Helper.sharedInstance.newsLinkArray, forKey: "linkDefaults")
        UserDefaults.standard.set(Helper.sharedInstance.newsDateArray, forKey: "dateDefaults")
        
        NotificationCenter.default.post(name: NSNotification.Name("NewData"), object: nil)
    }
    
}
