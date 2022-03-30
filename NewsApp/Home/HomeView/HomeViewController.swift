//
//  ViewController.swift
//  NewsApp
//
//  Created by Nihad Ismayilov on 29.03.22.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet var dotLabel: UILabel!
    @IBOutlet var dotLabel2: UILabel!
    @IBOutlet var dotLabel3: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var latestTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dotLabel.layer.cornerRadius = 10
        dotLabel2.layer.cornerRadius = 8
        dotLabel3.layer.cornerRadius = 5
        
        collectionView.delegate = self
        collectionView.dataSource = self
        latestTableView.delegate = self
        latestTableView.dataSource = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.items![0].image = UIImage(systemName: "house.fill")
        self.tabBarController?.tabBar.items![1].image = UIImage(systemName: "bookmark")
    }


}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as! CollectionViewCell
        cell.collectionTopicLabel.layer.cornerRadius = 16
        cell.collectionImageView.layer.cornerRadius = 16
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("tapped")
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = latestTableView.dequeueReusableCell(withIdentifier: "searchCell", for: indexPath) as! HomeTableViewCell
        cell.topicLabel.layer.cornerRadius = 8
        cell.tableImageView.layer.cornerRadius = 18
        return cell
    }
}

