//
//  Moves+CoreDataProperties.swift
//  
//
//  Created by Nitish on 15/02/17.
//
//

import Foundation
import CoreData


extension Moves {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Moves> {
        return NSFetchRequest<Moves>(entityName: "Moves");
    }

    @NSManaged public var name: String?
    @NSManaged public var pokemon: Pokemon?

}
