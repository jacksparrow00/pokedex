//
//  displayAlert.swift
//  pokedex
//
//  Created by Nitish on 17/02/17.
//  Copyright © 2017 Nitish. All rights reserved.
//

import Foundation
import UIKit
extension UIViewController{
    func displayAlert(error: String?){      //to display all the errors in the app
        performUIUpdatesOnMain {
            let alertController = UIAlertController()
            alertController.title = "Error"
            alertController.message = error
            let alertAction = UIAlertAction(title: "OK", style: .default)
            alertController.addAction(alertAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
}
