//
//  LocationAreaEncounters+CoreDataProperties.swift
//  
//
//  Created by Nitish on 15/02/17.
//
//

import Foundation
import CoreData


extension LocationAreaEncounters {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<LocationAreaEncounters> {
        return NSFetchRequest<LocationAreaEncounters>(entityName: "LocationAreaEncounters");
    }

    @NSManaged public var locationName: String?
    @NSManaged public var pokemon: Pokemon?

}
