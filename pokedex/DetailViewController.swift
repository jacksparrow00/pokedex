//
//  DetailViewController.swift
//  pokedex
//
//  Created by Nitish on 15/02/17.
//  Copyright © 2017 Nitish. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    var detail: String!
    var titleString: String!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var TitleLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(backButton))
        
        detailLabel.text = detail
        TitleLabel.text = titleString
    }
    
    func backButton(){
        dismiss(animated: true, completion: nil)
    }

}
