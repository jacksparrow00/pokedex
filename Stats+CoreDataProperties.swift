//
//  Stats+CoreDataProperties.swift
//  
//
//  Created by Nitish on 16/02/17.
//
//

import Foundation
import CoreData


extension Stats {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Stats> {
        return NSFetchRequest<Stats>(entityName: "Stats");
    }

    @NSManaged public var base_stat: Int16
    @NSManaged public var effort: Int16
    @NSManaged public var name: String?
    @NSManaged public var pokemon: Pokemon?

}
