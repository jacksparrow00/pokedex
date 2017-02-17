//
//  TableViewController.swift
//  pokedex
//
//  Created by Nitish on 11/02/17.
//  Copyright © 2017 Nitish. All rights reserved.
//

import UIKit
import CoreData

class TableViewController: UITableViewController,NSFetchedResultsControllerDelegate{              //http://www.learncoredata.com/nsfetchedresultscontroller-swift/
    
   //MARK: Properties
    
    lazy var context: NSManagedObjectContext = {
        return CoreDataStack.sharedInstance().persistentContainer.viewContext
    }()
    
    var fetchedResultsController : NSFetchedResultsController<NSFetchRequestResult>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let pokeObject = NSFetchRequest<NSFetchRequestResult>(entityName: "Pokemon")
        pokeObject.sortDescriptors = [NSSortDescriptor(key: "name", ascending: false),NSSortDescriptor(key:"id", ascending: true)]
        
        fetchedResultsController = NSFetchedResultsController(fetchRequest: pokeObject, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultsController.delegate = self
        
        do{
            try fetchedResultsController.performFetch()
        }catch let e as NSError{
            print("Unable to perform fetch: \(e.localizedDescription)")
        }
    }
    
    //MARK: tell the tableVC what we want in cells
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let pokemon = fetchedResultsController.object(at: indexPath) as! Pokemon
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonCell", for: indexPath)
        cell.textLabel?.text = pokemon.name
        cell.detailTextLabel?.text = String(pokemon.id)
        return cell
    }
    
    /*override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        //let detailVC = self.storyboard?.instantiateViewController(withIdentifier: "InfoVC") as? InfoViewController
        performSegue(withIdentifier: "SearchVC", sender: indexPath.row)
    }*/
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let sectionData = fetchedResultsController.sections?[section] else{
            return 0
        }
        return sectionData.numberOfObjects
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "SearchVC"{
            if let infoVC = segue.destination as? InfoViewController{
                
                let indexPath = tableView.indexPathForSelectedRow!
                let pokemon = fetchedResultsController?.object(at: indexPath) as? Pokemon
                
                infoVC.pokemon = pokemon
            }
        }
    }

}

