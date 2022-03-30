//
//  DetailsViewController.swift
//  NewsApp
//
//  Created by Nihad Ismayilov on 30.03.22.
//

import UIKit

class DetailsViewController: UIViewController {

    @IBOutlet var containerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        containerView.layer.cornerRadius = 64
    }
}
