//
//  DetailsViewController.swift
//  NewsApp
//
//  Created by Nihad Ismayilov on 30.03.22.
//

import UIKit
import SDWebImage
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
    
    var detailsModel: DetailsModel?
    let newsDetails = DetailsViewModel()

    @IBOutlet var detailsImageView: UIImageView!
    @IBOutlet var containerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Corner radius settings
        containerView.layer.cornerRadius = 32
        containerView.clipsToBounds = true
        containerView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        
        let menuHandler: UIActionHandler = { action in
            print(action.title)
        }

        let barButtonMenu = UIMenu(title: "", children: [
            UIAction(title: NSLocalizedString("Save", comment: ""), image: UIImage(systemName: "bookmark"), handler: menuHandler),
            UIAction(title: NSLocalizedString("Share", comment: ""), image: UIImage(systemName: "point.3.filled.connected.trianglepath.dotted"), handler: menuHandler),
        ])

        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "...", style: .plain, target: self, action: nil)
        navigationItem.rightBarButtonItem?.menu = barButtonMenu
        
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
            //print(twitterAPI)
        }
    }
    
    func showDetails() {
    }
}
