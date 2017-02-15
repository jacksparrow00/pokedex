//
//  HeldItems+CoreDataClass.swift
//  
//
//  Created by Nitish on 15/02/17.
//
//

import Foundation
import CoreData

@objc(HeldItems)
public class HeldItems: NSManagedObject {

    convenience init(context: NSManagedObjectContext) {
        if let ent = NSEntityDescription.entity(forEntityName: "HeldItems", in: context){
            self.init(entity: ent, insertInto: context)
            self.name = String()
        }else{
            fatalError("Unable to initialize held_items")
        }
    }
}
