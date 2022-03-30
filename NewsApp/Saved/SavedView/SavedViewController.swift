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

        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.items![0].image = UIImage(systemName: "house")
        self.tabBarController?.tabBar.items![1].image = UIImage(systemName: "bookmark.fill")
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
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = savedTableView.dequeueReusableCell(withIdentifier: "savedCell", for: indexPath) as! SavedTableViewCell
        cell.savedImageView.layer.cornerRadius = 18
        cell.savedTopicLabel.layer.cornerRadius = 10
        return cell
    }
}
