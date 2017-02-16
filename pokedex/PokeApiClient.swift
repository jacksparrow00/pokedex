//
//  PokeApiClient.swift
//  pokedex
//
//  Created by Nitish on 07/02/17.
//  Copyright © 2017 Nitish. All rights reserved.
//

import Foundation
import CoreData

class PokeApiClient{
    
    //request the pokeapi.co and recieve and parse data, save in core data
    class func sharedInstance() -> PokeApiClient{
        struct Singleton{
            static var sharedInstance = PokeApiClient()
        }
        
        return Singleton.sharedInstance
    }
    
    var session = URLSession.shared
    func taskForGetMethod(url:String, completionHandlerForGet: @escaping(_ data:AnyObject?,_ error: NSError?) -> Void){
        let request = URLRequest(url: URL(string: url)!)
        let task = session.dataTask(with: request) { (data, response, error) in
            func sendError(error:String){
                print(error)
                let userInfo = [NSLocalizedDescriptionKey:error]
                completionHandlerForGet(nil,NSError(domain: "taskForGetMethod", code: 1, userInfo: userInfo))
            }
            guard error == nil else{
                sendError(error: "There was an error with your request: \(error?.localizedDescription)")
                return
            }
            
            /*if let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode >= 200 && statusCode <= 299{
                print(statusCode)
            }else{
                sendError(error: "Your request returned status code other than 2xx")
                return
            }*/
            
            guard let data = data else{
                sendError(error: "Your request didn't returned any data")
                return
            }
            
            var parsedResult: AnyObject!
            do{
                parsedResult = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as AnyObject
            }catch{
                sendError(error: "Couldn't parse the data as JSON \(data)")
            }
            
            completionHandlerForGet(parsedResult,nil)
        }
        task.resume()
    }
    
    func getData(text: String,managedContext context: NSManagedObjectContext,completionHandlerForGetData: @escaping(_ pokemon: Pokemon?,_ success: Bool?,_ error:String?) -> Void) {
        let searchedPokemon = Pokemon(context: CoreDataStack.sharedInstance().persistentContainer.viewContext)
        let url = "http://pokeapi.co/api/v2/pokemon/" + "\(text)/"
        print(url)
        taskForGetMethod(url: url) { (data, error) in
            guard error == nil else{
                print(error!)
                completionHandlerForGetData(nil,false,"Couldn't find the name. This error was returned \(error?.localizedDescription)")
                return
            }
            
            guard let abilities = data?[PokeApiAbilitiesConstants.abilities] as? [[String:AnyObject]] else{
                print("Abilities key couldn't be found")
                return
            }
            
            for ability in abilities{
                guard let slot = ability[PokeApiAbilitiesConstants.slot] as? Int16 else{
                    print("slot key couldn't be found")
                    return
                }
                
                guard let isHidden = ability[PokeApiAbilitiesConstants.isHidden] as? Bool else{
                    print("is_hidden key couldn't be found")
                    return
                }
                
                guard let able = ability[PokeApiAbilitiesConstants.ability] as? [String:AnyObject] else{
                    print("ability key couldn't be found")
                    return
                }
                
                guard let name = able[PokeApiAbilitiesConstants.name] as? String else{
                    print("name key in ability couldn't be found")
                    return
                }
                
                
            //MARK: Assign keys to core data values
                
                context.perform {
                    let abilityDetail = Abilities(context: context)
                    
                    abilityDetail.ability_name = name
                    
                    abilityDetail.is_hidden = isHidden
                    
                    abilityDetail.slot = slot
                    
                    searchedPokemon.addToAblilities(abilityDetail)
                    print("saved abilities")
                }
            }
            
            guard let stats = data?[PokeApiStatsConstants.stats] as? [[String:AnyObject]] else{
                print("stats key couldn't be found")
                return
            }
            
            for stat in stats{
                guard let status = stat[PokeApiStatsConstants.stat] as? [String:AnyObject] else{
                    print("stat key couldn't be found")
                    return
                }
                
                guard let name = status[PokeApiStatsConstants.name] as? String else{
                    print("name key in stats couldn't be found")
                    return
                }
                
                guard let effort = stat[PokeApiStatsConstants.effort] as? Int16 else{
                    print("effort key couldn't be found")
                    return
                }
                
                guard let baseStat = stat[PokeApiStatsConstants.baseStat] as? Int16 else{
                    print("base_stat key couldn't be found")
                    return
                }
                
                
                //MARK: Assign keys to core data values
                
                context.perform {
                    let statsDetail = Stats(context: context)
                    
                    statsDetail.base_stat = baseStat
                    
                    statsDetail.name = name
                    
                    statsDetail.effort = effort
                    
                    searchedPokemon.addToStats(statsDetail)
                    
                    print("saved stats")
                }
            }
            
            guard let name = data?[PokeApiDetailsConstants.name] as? String else{
                print("pokemon name couldn't be found")
                return
            }
            
            guard let weight = data?[PokeApiDetailsConstants.weight] as? Int16 else{
                print("weight key couldn't be found")
                return
            }
            
            let weightInKgs = weight/10
            //MARK: Assign keys to core data values
            
            context.perform {
                searchedPokemon.name = name
                
                searchedPokemon.weight = Float(weightInKgs)
                print("saved name, weight")
            }
            
            
            guard let moves = data?[PokeApiMovesConstants.moves] as? [[String:AnyObject]] else{
                print("moves key couldn't be found")
                return
            }
            
            for moveObject in moves{
                guard let move = moveObject[PokeApiMovesConstants.move] as? [String:AnyObject] else{
                    print("move key couldn't be found")
                    return
                }
                
                guard let moveName = move[PokeApiMovesConstants.name] as? String else{
                    print("name key in move couldn't be found")
                    return
                }
                
                
                //MARK: Assign keys to core data values
                
                context.perform {
                    let moveDetails = Moves(context: context)
                    
                    moveDetails.name = moveName
                    
                    searchedPokemon.addToMoves(moveDetails)
                    
                    print("saved moves")
                }
            }
            
            guard let sprites = data?[PokeApiPhotosConstants.sprites] as? [String:AnyObject] else{
                print("sprites key couldn't be found")
                return
            }
            
            guard let frontDefault = sprites[PokeApiPhotosConstants.frontDefault] as? String else{
                print("front_default key couldn't be found")
                return
            }
            
            let imageURL = URL(string: frontDefault)
            print(imageURL!)
            let request = URLRequest(url: imageURL!)
            let task = self.session.dataTask(with: request, completionHandler: { (picData, picResponse, picError) in
                guard picError == nil else{
                    completionHandlerForGetData(nil,false,"Pokemon image couldn't be downloaded. \(picError?.localizedDescription)")
                    return
                }
                
                //MARK: Assign keys to core data values
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                //For some reason I am not able to assign the photo data to core data entitiy PHOTO. Please help me out here
                
                
                
                
                
                
                
                
                
                
                
                
                context.perform {
                    let pokemonPhoto = Photo(context: context)
                    
                    pokemonPhoto.pic = picData! as! NSData
                    pokemonPhoto.picUrl = frontDefault
                    
                    searchedPokemon.photo = pokemonPhoto
                    
                    print("saved photo")
                }
                
            })
            task.resume()
            
            guard let heldItems = data?[PokeApiHeldItemsConstants.heldItems] as? [[String:AnyObject]] else{
                print("held items key couldn't be found")
                return
            }
            
            for heldItem in heldItems{
                guard let item = heldItem[PokeApiHeldItemsConstants.item] as? [String:AnyObject] else{
                    print("item key couldn't be found")
                    return
                }
                
                guard let name = item[PokeApiHeldItemsConstants.name] as? String else{
                    print("name key in held items couldn't be found")
                    return
                }
                
                //MARK: Assign keys to core data values
                
                context.perform {
                    let heldItemsDetails = HeldItems(context: context)
                    
                    heldItemsDetails.name = name
                    
                    searchedPokemon.addToHeldItems(heldItemsDetails)
                    
                    print("saved heldItems")
                }
            }
            
            guard let locationEncounter = data?[PokeApiLocationEncounterConstants.locationAreaEncounters] as? String else{
                print("location_area_encounters key couldn't be found")
                return
            }
            
            print(locationEncounter)
            
            let locationURL = "http://pokeapi.co" + locationEncounter
            
            print(locationURL)
            
            self.taskForGetMethod(url: locationURL, completionHandlerForGet: { (newData, newError) in
                guard newError == nil else{
                    print(newError!)
                    completionHandlerForGetData(nil,false, "location_area_encounter url returned an error \(newError?.localizedDescription)")
                    return
                }
                
                guard let locationData = newData as? [AnyObject] else{     //http://stackoverflow.com/questions/34813387/to-parse-json-to-nsarray-in-swift
                    print("Couldn't find array of locations")
                    return
                }
                
                for object in locationData{
                    guard let locationArea = object[PokeApiLocationEncounterConstants.locationArea] as? [String:AnyObject] else{
                        print("location_area key couldn't be found")
                        return
                    }
                    
                    guard let name = locationArea[PokeApiLocationEncounterConstants.name] as? String else{
                        print("name in location_area key couldn't be found")
                        return
                    }
                    
                    
                    //MARK: Assign values to core data
                    
                    context.perform {
                        let locationDataDetails = LocationAreaEncounters(context: context)
                        
                        locationDataDetails.locationName = name
                        
                        searchedPokemon.addToLocationAreaEncounters(locationDataDetails)
                        
                        print("saved location areas")
                    }
                }
            })
            
            guard let height = data?[PokeApiDetailsConstants.height] as? Int else{
                print("height key couldn't be found")
                return
            }
            
            guard let isDefault = data?[PokeApiDetailsConstants.isDefault] as? Bool else{
                print("is_default key couldn't be found")
                return
            }
            
            guard let id = data?[PokeApiDetailsConstants.id] as? Int else{
                print("id key couldn't be found")
                return
            }
            
            /*guard let order = data?[PokeApiDetailsConstants.order] as? Int else{
                print("order key couldn't be found")
                return
            }*/
            
            guard let baseExperience = data?[PokeApiDetailsConstants.baseExperience] as? Int else{
                print("base_experience key couldn't be found")
                return
            }
            
            
            
            //MARK: Assign values to core data values
            
            context.perform {
                searchedPokemon.height = Float(height/10)
                searchedPokemon.isDefault = isDefault
                searchedPokemon.id = Int16(id)
                searchedPokemon.baseExperience = Int16(baseExperience)
                
                print("saved height, isDefault, id, baseexperience")
            }
            
            guard let types = data?[PokeApiTypeConstants.types] as? [[String:AnyObject]] else{
                print("types key couldn't be found")
                return
            }
            
            for typeObject in types{
                guard let slot = typeObject[PokeApiTypeConstants.slot] as? Int else{
                    print("slot key couldn't be found")
                    return
                }
                
                guard let type = typeObject[PokeApiTypeConstants.type] as? [String:AnyObject] else{
                    print("type key couldn't be found")
                    return
                }
                
                guard let name = type[PokeApiTypeConstants.name] as? String else{
                    print("name key in type couldn't be found")
                    return
                }
                
                
                
                //MARK: Assign values to core data values
                
                context.perform {
                    let typesDetails = Types(context: context)
                    
                    typesDetails.name = name
                    
                    typesDetails.slot = Int16(slot)
                    
                    searchedPokemon.addToTypes(typesDetails)
                    
                    print("saved types")
                }
                
                
            }
            
            print("now saving all the data")
            do{
             try context.save()
            }catch{
                print("Couldn't save")
            }
            
            /*do{
                try! CoreDataStack.sharedInstance().persistentContainer.viewContext.save()
            }catch{
                print("Error while saving")
            }*/
            
            completionHandlerForGetData(searchedPokemon,true,nil)
            
            
        }
        
    }
}
