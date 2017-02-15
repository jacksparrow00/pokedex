//
//  Stats+CoreDataClass.swift
//  
//
//  Created by Nitish on 15/02/17.
//
//

import Foundation
import CoreData

@objc(Stats)
public class Stats: NSManagedObject {
    
    convenience init(context: NSManagedObjectContext) {
        if let ent = NSEntityDescription.entity(forEntityName: "Stats", in: context){
            self.init(entity: ent, insertInto: context)
            self.base_stat = Int16()
            self.effort = Int16()
            self.name = String()
        }else{
            fatalError("Unable to initialize stats")
        }
    }

}
