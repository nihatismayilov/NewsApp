//
//  ChildViewController.swift
//  NewsApp
//
//  Created by Nihad Ismayilov on 30.03.22.
//

import UIKit
import SafariServices

class ChildViewController: UIViewController {
    
    var topicText: String?
    var titleText: String?
    var authorText: String?
    var excerptText: String?
    var summaryText: String?
    var linkText: String?
    var twitterText: String?
    
    @IBOutlet var containerTopicLabel: UILabel!
    @IBOutlet var containerTitleLabel: UILabel!
    @IBOutlet var containerAuthorLabel: UILabel!
    @IBOutlet var containerExcerptLabel: UILabel!
    @IBOutlet var containerSummaryLabel: UILabel!
    @IBOutlet var containerReadMoreLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        containerTopicLabel.layer.cornerRadius = 10
        
        //print("Twitter account: \(twitterText)")
        
        showDetails()
        
        // Gesture recognizers
        containerReadMoreLabel.isUserInteractionEnabled = true
        let readMoreGesture = UITapGestureRecognizer(target: self, action: #selector(readMoreClicked))
        containerReadMoreLabel.addGestureRecognizer(readMoreGesture)
        
        containerAuthorLabel.isUserInteractionEnabled = true
        let authorGesture = UITapGestureRecognizer(target: self, action: #selector(authorClicked))
        containerAuthorLabel.addGestureRecognizer(authorGesture)
        
    }
    
    func showDetails() {
        containerTopicLabel.text = topicText ?? "No data"
        containerTitleLabel.text = titleText ?? "No data"
        containerAuthorLabel.text = authorText ?? "No data"
        containerExcerptLabel.text = excerptText ?? "No data"
        containerSummaryLabel.text = summaryText ?? "No data"
    }
    
    @objc func readMoreClicked() {
        if let moreUrl  = linkText {
            let safariVC = SFSafariViewController(url: URL(string: moreUrl)!)
            present(safariVC, animated: true)
        }
    }
    
    @objc func authorClicked() {
        if twitterText != "No data" && twitterText != "" {
            let safariVC = SFSafariViewController(url: URL(string: "https://twitter.com/\(twitterText!)")!)
            present(safariVC, animated: true)
        } else {
            makeALert()
        }
    }
    
    func makeALert() {
        let alert = UIAlertController(title: "Error!", message: "Couldn't find twitter account", preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
        alert.addAction(okButton)
        present(alert, animated: true)
    }
}
