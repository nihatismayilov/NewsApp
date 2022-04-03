//
//  SavedViewController.swift
//  NewsApp
//
//  Created by Nihad Ismayilov on 30.03.22.
//

import UIKit

class SavedViewController: UIViewController {
    
    @IBOutlet var dotLabelSaved: UILabel!
    @IBOutlet var savedDateLabel: UILabel!
    @IBOutlet var savedTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dotLabelSaved.layer.cornerRadius = 10
        
        getDate()
        
        savedTableView.delegate = self
        savedTableView.dataSource = self
        
        Helper.sharedInstance.newsMediaArray = UserDefaults.standard.array(forKey: "mediaDefaults") as? [String]
        Helper.sharedInstance.newsTopicArray = UserDefaults.standard.array(forKey: "topicDefaults") as? [String]
        Helper.sharedInstance.newsTitleArray = UserDefaults.standard.array(forKey: "titleDefaults") as? [String]
        Helper.sharedInstance.newsAuthorArray = UserDefaults.standard.array(forKey: "authorDefaults") as? [String]
        Helper.sharedInstance.newsTwitterAccountArray = UserDefaults.standard.array(forKey: "twitterAccountDefaults") as? [String]
        Helper.sharedInstance.newsExcerptArray = UserDefaults.standard.array(forKey: "excerptDefaults") as? [String]
        Helper.sharedInstance.newsSummaryArray = UserDefaults.standard.array(forKey: "summaryDefaults") as? [String]
        Helper.sharedInstance.newsLinkArray = UserDefaults.standard.array(forKey: "linkDefaults") as? [String]
        Helper.sharedInstance.newsDateArray = UserDefaults.standard.array(forKey: "dateDefaults") as? [String]
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.items![0].image = UIImage(systemName: "house")
        self.tabBarController?.tabBar.items![1].image = UIImage(systemName: "bookmark.fill")
        
        self.savedTableView.reloadData()
    }
    
    func getDate() {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, yyyy"
        dateFormatter.dateStyle = .long
        savedDateLabel.text = "\(dateFormatter.string(from: date))"
    }
    
}

extension SavedViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Helper.sharedInstance.newsTitleArray?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = savedTableView.dequeueReusableCell(withIdentifier: "savedCell", for: indexPath) as! SavedTableViewCell
        cell.savedImageView.layer.cornerRadius = 18
        cell.savedTopicLabel.layer.cornerRadius = 10
        
        DispatchQueue.main.async {
            cell.savedTopicLabel.text = Helper.sharedInstance.newsTopicArray?[indexPath.row]
            cell.savedTitleLabel.text = Helper.sharedInstance.newsTitleArray?[indexPath.row]
            cell.savedAuthorLabel.text = Helper.sharedInstance.newsAuthorArray?[indexPath.row]
            cell.savedDateLabel.text = Helper.sharedInstance.newsDateArray?[indexPath.row]
            if let imageUrl = Helper.sharedInstance.newsMediaArray?[indexPath.row] {
                cell.savedImageView.sd_setImage(with: URL(string: imageUrl))
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let board = UIStoryboard(name: "Main", bundle: nil)
        let detailsVC = board.instantiateViewController(withIdentifier: "details") as! DetailsViewController
        
        detailsVC.mediaAPI = Helper.sharedInstance.newsMediaArray?[indexPath.row]
        detailsVC.topicAPI = Helper.sharedInstance.newsTopicArray?[indexPath.row]
        detailsVC.titleAPI = Helper.sharedInstance.newsTitleArray?[indexPath.row]
        detailsVC.authorAPI = Helper.sharedInstance.newsAuthorArray?[indexPath.row]
        detailsVC.twitterAPI = Helper.sharedInstance.newsTwitterAccountArray?[indexPath.row]
        detailsVC.excerptAPI = Helper.sharedInstance.newsExcerptArray?[indexPath.row]
        detailsVC.summaryAPI = Helper.sharedInstance.newsSummaryArray?[indexPath.row]
        detailsVC.linkAPI = Helper.sharedInstance.newsLinkArray?[indexPath.row]
        detailsVC.dateAPI = Helper.sharedInstance.newsDateArray?[indexPath.row]
        detailsVC.from = "Save"
        
        navigationController?.pushViewController(detailsVC, animated: true)
    }
}
