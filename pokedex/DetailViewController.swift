//
//  DetailViewController.swift
//  pokedex
//
//  Created by Nitish on 15/02/17.
//  Copyright © 2017 Nitish. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {      //display the remaining info
    var detail: String!
    var titleString: String!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var TitleLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        detailLabel.numberOfLines = 0
        detailLabel.lineBreakMode = .byWordWrapping
        detailLabel.text = detail
        
        TitleLabel.numberOfLines = 0
        TitleLabel.lineBreakMode = .byWordWrapping
        TitleLabel.text = titleString
    }
    
    
    @IBAction func backButton(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }

}
