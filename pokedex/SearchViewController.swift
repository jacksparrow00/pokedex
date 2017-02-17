//
//  SearchViewController.swift
//  pokedex
//
//  Created by Nitish on 13/02/17.
//  Copyright © 2017 Nitish. All rights reserved.
//

import UIKit


class SearchViewController: UIViewController {
    
    var isSuccessful:Bool = false
    var textmode: Bool = false
    var pokemons = [Pokemon]()
    var selectedPokemon : Pokemon!
    var searchTask: URLSessionDataTask?
    let appDelegate = AppDelegate()

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // configure tap recognizer
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleSingleTap(_:)))
        tapRecognizer.numberOfTapsRequired = 1
        tapRecognizer.delegate = self
        view.addGestureRecognizer(tapRecognizer)
    }
    
    func handleSingleTap(_ recognizer: UITapGestureRecognizer){
        view.endEditing(true)
    }
    
    
    @IBAction func selectMode(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            textmode = false
            searchBar.placeholder = "Search by name"
        case 1:
            textmode = true
            searchBar.placeholder = "Search by id"
        default:
            textmode = false
            searchBar.placeholder = "Search by name"
        }
    }

}



extension SearchViewController:UIGestureRecognizerDelegate{
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        return searchBar.isFirstResponder
    }
    
}


//searchBarDelegate assigned
extension SearchViewController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if let task = searchTask{
            task.cancel()
        }
        
        if searchText == ""{
            pokemons = [Pokemon]()
            tableView.reloadData()
            return
        }
        
        if isSuccessful == true{
            UIApplication.shared.isNetworkActivityIndicatorVisible = true                   // indicating network activity
            
            PokeApiClient.sharedInstance().getData(text: searchText, managedContext: CoreDataStack.sharedInstance().persistentContainer.viewContext, completionHandlerForGetData: { (pokemon,response, error) in
                guard error == nil else{
                    self.displayAlert(error: error)
                    return
                }
                
                /*do{
                   try! CoreDataStack.sharedInstance().persistentContainer.viewContext.save()
                }catch{
                    print("Error while saving")
                }*/
                performUIUpdatesOnMain {
                    self.selectedPokemon = pokemon!
                    self.performSegue(withIdentifier: "newVC", sender: nil)
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                }
                
            })
        } else{
            
            
            //Use FMDB framework to search:-    http://codelle.com/blog/2016/3/simple-core-data-full-text-search-with-swift-and-sqlite/
            
            
            
            var localPokemon = Pokemon(context: CoreDataStack.sharedInstance().persistentContainer.viewContext)
            let index = SearchIndex()
            index.insertSearchable(object: localPokemon)
            do{
                try! self.pokemons = index.searchForManagedObjectsWithQuery(query: searchText, inManagedObjectContext: CoreDataStack.sharedInstance().persistentContainer.viewContext) as! [Pokemon]
            } catch{
                print("No related pokemon found in core data")
                
            }
            isSuccessful = true
            
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    
    //allow particular characters in specific modes
    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        var allowed: Bool = true
        if textmode{
            let allowedCharacters = CharacterSet.decimalDigits
            let characterSet = CharacterSet(charactersIn: text)
            allowed = allowedCharacters.isSuperset(of: characterSet)
            if !allowed{
                self.displayAlert(error: "Only numbers are allowed")
            }
        }else{
            let allowedCharacters = CharacterSet.lowercaseLetters
            let characterSet = CharacterSet(charactersIn: text)
            allowed = allowedCharacters.isSuperset(of: characterSet)
            if !allowed{
                self.displayAlert(error: "Upper case letters not allowed. Please switch to lower case")
            }
        }
        return allowed
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "newVC"{
            if let newVC = segue.destination as? InfoViewController{
                newVC.pokemon = self.selectedPokemon
            }
        }
    }
}


//

extension SearchViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let poke = pokemons[(indexPath as NSIndexPath).row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")! as UITableViewCell
        
        cell.textLabel?.text = poke.name
        cell.detailTextLabel?.text = String(poke.id)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = pokemons.count as? Int{
            return count
        }else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedPokemon = pokemons[(indexPath as NSIndexPath).row]
        performSegue(withIdentifier: "newVC", sender: indexPath)
    }
}
