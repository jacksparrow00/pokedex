//
//  TableViewController.swift
//  pokedex
//
//  Created by Nitish on 11/02/17.
//  Copyright © 2017 Nitish. All rights reserved.
//

import UIKit
import CoreData

class TableViewController: UITableViewController {              //Just like the CoolNotesApp project code in tutorials
    
    //MARK: properties
    
    var fetchedResultsController : NSFetchedResultsController<NSFetchRequestResult>? {
        didSet {
            // Whenever the frc changes, we execute the search and
            // reload the table
            fetchedResultsController?.delegate = self
            executeSearch()
            tableView.reloadData()
        }
    }
    
    
    //MARK: Initializers
    init(fetchedResultsController fc: NSFetchedResultsController<NSFetchRequestResult>,style: UITableViewStyle = .plain) {
        super.init(style: style)
    }
    
    //Only because it's necessary
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        //create a fetchRequest
        let fr = NSFetchRequest<NSFetchRequestResult>(entityName: "Pokemon")
        fr.sortDescriptors = [NSSortDescriptor(key: "name", ascending: false),
                              NSSortDescriptor(key: "id", ascending: true)]
        
        //Create the FetchResultsController
        
        fetchedResultsController = NSFetchedResultsController(fetchRequest: fr, managedObjectContext: CoreDataStack.sharedInstance().persistentContainer.viewContext, sectionNameKeyPath: nil, cacheName: nil)
    }
    
    //MARK: tell the tableVC what we want in cells
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let poke = fetchedResultsController?.object(at: indexPath) as! Pokemon
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonCell")! as UITableViewCell
        
        cell.textLabel?.text = poke.name
        cell.detailTextLabel?.text = String(poke.id)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        //let detailVC = self.storyboard?.instantiateViewController(withIdentifier: "InfoVC") as? InfoViewController
        performSegue(withIdentifier: "InfoVC", sender: indexPath)
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        if let fc = fetchedResultsController{
            return (fc.sections?.count)!
        }else{
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let fc = fetchedResultsController{
            return fc.sections![section].numberOfObjects
        }else{
            return 0
        }
    }
    
    func executeSearch(){
        if let fc = fetchedResultsController{
            do{
                try fc.performFetch()
            }catch let e as NSError{
                print("Error while trying to perform a search: \n\(e)\n\(fetchedResultsController)")
            }
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "InfoVC"{
            if let infoVC = segue.destination as? InfoViewController{
                
                let pokeObject = NSFetchRequest<NSFetchRequestResult>(entityName: "Pokemon")
                pokeObject.sortDescriptors = [NSSortDescriptor(key: "name", ascending: false),NSSortDescriptor(key:"id", ascending: true)]
                
                /*let locationObject = NSFetchRequest<NSFetchRequestResult>(entityName: "LocationAreaEncounters")
                locationObject.sortDescriptors = [NSSortDescriptor(key: "locationName", ascending: true)]
                
                let heldItemsObject = NSFetchRequest<NSFetchRequestResult>(entityName: "HeldItems")
                heldItemsObject.sortDescriptors = [NSSortDescriptor(key: "name",ascending: true)]
                
                let abilitiesObject = NSFetchRequest<NSFetchRequestResult>(entityName: "Abilities")
                abilitiesObject.sortDescriptors = [NSSortDescriptor(key: "ability_name",ascending: false),
                                                   NSSortDescriptor(key: "is_hidden", ascending: false),
                                                   NSSortDescriptor(key: "slot", ascending: true)]
                
                let movesObject = NSFetchRequest<NSFetchRequestResult>(entityName: "Moves")
                movesObject.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
                
                let statsObject = NSFetchRequest<NSFetchRequestResult>(entityName: "Stats")
                statsObject.sortDescriptors = [NSSortDescriptor(key: "base_stat", ascending: false),
                                               NSSortDescriptor(key: "effort", ascending: false),
                                               NSSortDescriptor(key: "name", ascending: true)]
                
                let typeObject = NSFetchRequest<NSFetchRequestResult>(entityName: "Types")
                typeObject.sortDescriptors = [NSSortDescriptor(key: "name", ascending: false),
                                              NSSortDescriptor(key: "slot", ascending: true)]*/
                
                let indexPath = tableView.indexPathForSelectedRow!
                let pokemon = fetchedResultsController?.object(at: indexPath) as? Pokemon
                
                /*let predicate = NSPredicate(format: "pokemon = %@", argumentArray: [pokemon!])
                
                pokeObject.predicate = predicate*/
                
                /*locationObject.predicate = predicate
                heldItemsObject.predicate = predicate
                abilitiesObject.predicate = predicate
                movesObject.predicate = predicate
                statsObject.predicate = predicate
                typeObject.predicate = predicate*/
                
                /*let locationObjectFc = NSFetchedResultsController(fetchRequest: locationObject, managedObjectContext: fetchedResultsController!.managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
                
                let heldItemsObjectFc = NSFetchedResultsController(fetchRequest: heldItemsObject, managedObjectContext: fetchedResultsController!.managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
                
                let abilitiesObjectFc = NSFetchedResultsController(fetchRequest: abilitiesObject, managedObjectContext: fetchedResultsController!.managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
                
                let movesObjectFc = NSFetchedResultsController(fetchRequest: movesObject, managedObjectContext: fetchedResultsController!.managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
                
                let statsObjectFc = NSFetchedResultsController(fetchRequest: statsObject, managedObjectContext: fetchedResultsController!.managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
                
                let typeObjectFc = NSFetchedResultsController(fetchRequest: typeObject, managedObjectContext: fetchedResultsController!.managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)*/
                
                //MAARK: Implement last two statements
                //infoVC.fetchedResultsController = locationObjectFc
                
                infoVC.pokemon = pokemon
                
                /*let locationObjectFc = NSFetchedResultsController(fetchRequest: locationObject, managedObjectContext: fetchedResultsController!.managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
                
                infoVC.fetchedResultsController = locationObjectFc
                infoVC.location =*/
                
            }
        
        }
    }

}

extension TableViewController : NSFetchedResultsControllerDelegate{
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        switch (type) {
        case .insert:
            tableView.insertRows(at: [newIndexPath!], with: .fade)
        case .delete:
            tableView.deleteRows(at: [indexPath!], with: .fade)
        case .update:
            tableView.reloadRows(at: [indexPath!], with: .fade)
        case .move:
            tableView.deleteRows(at: [indexPath!], with: .fade)
            tableView.insertRows(at: [newIndexPath!], with: .fade)
        default:
            break
        }
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
        let set = IndexSet(integer: sectionIndex)
        
        switch (type) {
        case .insert:
            tableView.insertSections(set, with: .fade)
            
        case .delete:
            tableView.deleteSections(set, with: .fade)
        default:
            break
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
}
