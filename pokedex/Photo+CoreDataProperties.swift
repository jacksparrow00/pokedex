//
//  Photo+CoreDataProperties.swift
//  
//
//  Created by Nitish on 15/02/17.
//
//

import Foundation
import CoreData


extension Photo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Photo> {
        return NSFetchRequest<Photo>(entityName: "Photo");
    }

    @NSManaged public var pic: NSData?
    @NSManaged public var picUrl: String?
    @NSManaged public var pokemon: Pokemon?

}
