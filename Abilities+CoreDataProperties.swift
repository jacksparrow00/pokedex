//
//  Abilities+CoreDataProperties.swift
//  
//
//  Created by Nitish on 16/02/17.
//
//

import Foundation
import CoreData


extension Abilities {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Abilities> {
        return NSFetchRequest<Abilities>(entityName: "Abilities");
    }

    @NSManaged public var ability_name: String?
    @NSManaged public var is_hidden: Bool
    @NSManaged public var slot: Int16
    @NSManaged public var pokemon: Pokemon?

}
