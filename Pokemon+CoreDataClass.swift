//
//  Pokemon+CoreDataClass.swift
//  
//
//  Created by Nitish on 16/02/17.
//
//

import Foundation
import CoreData

@objc(Pokemon)
public class Pokemon: NSManagedObject {
    
    convenience init(context: NSManagedObjectContext) {
        if let ent = NSEntityDescription.entity(forEntityName: "Pokemon", in: context){
            self.init(entity: ent, insertInto: context)
            self.name = String()
            self.baseExperience = Int16()
            self.id = Int16()
            self.weight = Float()
            self.isDefault = Bool()
            self.height = Float()
        }else{
            fatalError("Unable to initialise pokemon")
        }
    }
}

extension Pokemon: Searchable{
    var searchableStrings: [String]{
        return [name!, String(id)].flatMap{ $0 }
    }
}
