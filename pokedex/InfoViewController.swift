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
    var typeDisplay: String!
    var abilitiesDisplay: String!
    var heldItemsDisplay: String!
    var locationDetails: String!
    var movesDetail:String!
    var statsDetail:String!
    
    @IBOutlet weak var pokemonName: UILabel!
    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var baseExperienceLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    /*var fetchedResultsController : NSFetchedResultsController<NSFetchRequestResult>? {
        didSet {
            // Whenever the frc changes, we execute the search and
            // reload the table
            fetchedResultsController?.delegate = self
            executeSearch()
        }
    }*/
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.startAnimating()
        displayInfo()
        activityIndicator.stopAnimating()
    }
    
    func displayInfo(){
        pokemonName.text = pokemon.name
        pokemonImage.image = UIImage(data: (pokemon.photo?.pic)! as Data)
        idLabel.text = String(pokemon.id)
        baseExperienceLabel.text = String(pokemon.baseExperience)
        heightLabel.text = String(pokemon.height)
        weightLabel.text = String(pokemon.weight)
        
        for type in pokemon.types!{
            typeDisplay.append((type as! Types).name!)
            typeDisplay.append("(\((type as! Types).slot),")
        }
        
        typeLabel.text = typeDisplay
        
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
            heldItemsDisplay.append(", ")
        }
        
        for location in pokemon.locationAreaEncounters!{
            locationDetails.append((location as! LocationAreaEncounters).locationName!)
            locationDetails.append(", ")
        }
        
        for move in pokemon.moves!{
            movesDetail.append((move as! Moves).name!)
            movesDetail.append(", ")
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
