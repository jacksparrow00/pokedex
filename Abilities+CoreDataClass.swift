//
//  Abilities+CoreDataClass.swift
//  
//
//  Created by Nitish on 16/02/17.
//
//

import Foundation
import CoreData

@objc(Abilities)
public class Abilities: NSManagedObject {

    
    convenience init(context: NSManagedObjectContext) {
        if let ent = NSEntityDescription.entity(forEntityName: "Abilities", in: context){
            self.init(entity: ent, insertInto: context)
            self.ability_name = String()
            self.is_hidden = Bool()
            self.slot = Int16()
        }else{
            fatalError("Unable to initialize abilities")
        }
    }
}
