//
//  HeldItems+CoreDataProperties.swift
//  
//
//  Created by Nitish on 15/02/17.
//
//

import Foundation
import CoreData


extension HeldItems {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<HeldItems> {
        return NSFetchRequest<HeldItems>(entityName: "HeldItems");
    }

    @NSManaged public var name: String?
    @NSManaged public var pokemon: Pokemon?

}
