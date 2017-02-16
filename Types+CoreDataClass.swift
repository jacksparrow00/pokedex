//
//  Types+CoreDataClass.swift
//  
//
//  Created by Nitish on 16/02/17.
//
//

import Foundation
import CoreData

@objc(Types)
public class Types: NSManagedObject {
    
    convenience init(context: NSManagedObjectContext) {
        if let ent = NSEntityDescription.entity(forEntityName: "Types", in: context){
            self.init(entity: ent, insertInto : context)
            self.name = String()
            self.slot = Int16()
        }else{
            fatalError("Unable to initialize the types")
        }
    }

}
