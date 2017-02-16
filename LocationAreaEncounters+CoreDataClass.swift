//
//  LocationAreaEncounters+CoreDataClass.swift
//  
//
//  Created by Nitish on 16/02/17.
//
//

import Foundation
import CoreData

@objc(LocationAreaEncounters)
public class LocationAreaEncounters: NSManagedObject {
    
    
    convenience init(context: NSManagedObjectContext) {
        if let ent = NSEntityDescription.entity(forEntityName: "LocationAreaEncounters", in: context){
            self.init(entity: ent, insertInto: context)
            self.locationName = String()
        }else{
            fatalError("Unable to initialize locationAreaEncounters")
        }
    }
}
