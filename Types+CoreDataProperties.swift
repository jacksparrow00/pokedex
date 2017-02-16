//
//  Types+CoreDataProperties.swift
//  
//
//  Created by Nitish on 16/02/17.
//
//

import Foundation
import CoreData


extension Types {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Types> {
        return NSFetchRequest<Types>(entityName: "Types");
    }

    @NSManaged public var name: String?
    @NSManaged public var slot: Int16
    @NSManaged public var pokemon: Pokemon?

}
