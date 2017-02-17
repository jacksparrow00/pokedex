//
//  InfoViewController.swift
//  pokedex
//
//  Created by Nitish on 12/02/17.
//  Copyright © 2017 Nitish. All rights reserved.
//

import UIKit
import CoreData
import Foundation

class InfoViewController: UIViewController {

    var pokemon: Pokemon!
    var typeDisplay: String = ""
    var abilitiesDisplay: String = ""
    var heldItemsDisplay: String = ""
    var locationDetails: String = ""
    var movesDetail:String = ""
    var statsDetail:String = ""
    
    @IBOutlet weak var pokemonName: UILabel!
    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var baseExperienceLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        displayInfo()
    }
    
    @IBAction func backPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    
    
    //display all the saved info
    
    func displayInfo(){
        
        
        
        
        
        pokemonName.text = pokemon.name
        PokeApiClient.sharedInstance().downloadImage(imagePath: (pokemon.photo?.picUrl)!) { (data, error) in
            self.activityIndicator.startAnimating()
            guard error == nil else{
                self.displayAlert(error: error)
                return
            }
            
            CoreDataStack.sharedInstance().persistentContainer.viewContext.perform {
                self.pokemon.photo?.pic = data
                performUIUpdatesOnMain {
                    self.activityIndicator.stopAnimating()
                    self.activityIndicator.isHidden = true
                    self.pokemonImage.image = UIImage(data: data as! Data)
                }
            }
        }
        
        CoreDataStack.sharedInstance().persistentContainer.viewContext.perform {
            print("photo saved")
            CoreDataStack.sharedInstance().saveContext()
        }
        //pokemonImage.image = UIImage(data: (pokemon.photo?.pic)! as Data)
        idLabel.text = String(pokemon.id)
        baseExperienceLabel.text = String(pokemon.baseExperience)
        heightLabel.text = String(pokemon.height)
        weightLabel.text = String(pokemon.weight)
        
        for type in pokemon.types!{
            typeDisplay.append((type as! Types).name!)
            typeDisplay.append("(\((type as! Types).slot)),")
        }
        
        typeLabel.numberOfLines = 0
        typeLabel.lineBreakMode = .byWordWrapping
        typeLabel.text = typeDisplay
        
        activityIndicator.stopAnimating()
        
        for ability in pokemon.ablilities!{
            abilitiesDisplay.append((ability as! Abilities).ability_name!)
            if (ability as! Abilities).is_hidden{
                abilitiesDisplay.append("(hidden)")
            }else{
                abilitiesDisplay.append("(visible)")
            }
            
            abilitiesDisplay.append("(\((ability as! Abilities).slot)),")
        }

        for heldItem in pokemon.heldItems!{
            heldItemsDisplay.append((heldItem as! HeldItems).name!)
            heldItemsDisplay.append(",")
        }
        
        for location in pokemon.locationAreaEncounters!{
            locationDetails.append((location as! LocationAreaEncounters).locationName!)
            locationDetails.append(",")
        }
        
        for move in pokemon.moves!{
            movesDetail.append((move as! Moves).name!)
            movesDetail.append(",")
        }
        
        for stat in pokemon.stats!{
            statsDetail.append((stat as! Stats).name!)
            statsDetail.append(" = ")
            statsDetail.append("(\((stat as! Stats).base_stat)),")
        }
        
    }
    
    
    @IBAction func abilitiesButton(_ sender: Any) {
        performSegue(withIdentifier: "AbilitiesSegue", sender: sender)
    }
    
    @IBAction func heldItemsButton(_ sender: Any) {
        performSegue(withIdentifier: "HeldItemsSegue", sender: sender)
    }
    
    @IBAction func locationButton(_ sender: Any) {
        performSegue(withIdentifier: "locationSegue", sender: sender)
    }
    @IBAction func statsButton(_ sender: Any) {
        performSegue(withIdentifier: "StatsSegue", sender: sender)
    }
    
    @IBAction func movesButton(_ sender: Any) {
        performSegue(withIdentifier: "MovesSegue", sender: sender)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AbilitiesSegue"{
            let detailVC = segue.destination as! DetailViewController
            detailVC.detail = abilitiesDisplay
            detailVC.titleString = "Abilities"
        }else if segue.identifier == "MovesSegue"{
            let detailVC = segue.destination as! DetailViewController
            detailVC.detail = movesDetail
            detailVC.titleString = "Moves"
        }else if segue.identifier == "StatsSegue"{
            let detailVC = segue.destination as! DetailViewController
            detailVC.detail = statsDetail
            detailVC.titleString = "Stats"
        }else if segue.identifier == "HeldItemsSegue"{
            let detailVC = segue.destination as! DetailViewController
            detailVC.detail = heldItemsDisplay
            detailVC.titleString = "Held Items"
        }else if segue.identifier == "locationSegue"{
            let detailVC = segue.destination as! DetailViewController
            detailVC.detail = locationDetails
            detailVC.titleString = "Location Area Encounters"
        }
    }
}
