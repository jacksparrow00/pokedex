//
//  Moves+CoreDataClass.swift
//  
//
//  Created by Nitish on 16/02/17.
//
//

import Foundation
import CoreData

@objc(Moves)
public class Moves: NSManagedObject {

    
    convenience init(context: NSManagedObjectContext) {
        if let ent = NSEntityDescription.entity(forEntityName: "Moves", in: context){
            self.init(entity: ent, insertInto: context)
            self.name = String()
        }else{
            fatalError("Unable to initialize moves")
        }
    }
}
