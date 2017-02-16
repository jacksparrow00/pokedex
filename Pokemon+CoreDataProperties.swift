//
//  Pokemon+CoreDataProperties.swift
//  
//
//  Created by Nitish on 16/02/17.
//
//

import Foundation
import CoreData


extension Pokemon {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Pokemon> {
        return NSFetchRequest<Pokemon>(entityName: "Pokemon");
    }

    @NSManaged public var baseExperience: Int16
    @NSManaged public var height: Float
    @NSManaged public var id: Int16
    @NSManaged public var isDefault: Bool
    @NSManaged public var name: String?
    @NSManaged public var weight: Float
    @NSManaged public var ablilities: NSSet?
    @NSManaged public var heldItems: NSSet?
    @NSManaged public var locationAreaEncounters: NSSet?
    @NSManaged public var moves: NSSet?
    @NSManaged public var photo: Photo?
    @NSManaged public var stats: NSSet?
    @NSManaged public var types: NSSet?

}

// MARK: Generated accessors for ablilities
extension Pokemon {

    @objc(addAblilitiesObject:)
    @NSManaged public func addToAblilities(_ value: Abilities)

    @objc(removeAblilitiesObject:)
    @NSManaged public func removeFromAblilities(_ value: Abilities)

    @objc(addAblilities:)
    @NSManaged public func addToAblilities(_ values: NSSet)

    @objc(removeAblilities:)
    @NSManaged public func removeFromAblilities(_ values: NSSet)

}

// MARK: Generated accessors for heldItems
extension Pokemon {

    @objc(addHeldItemsObject:)
    @NSManaged public func addToHeldItems(_ value: HeldItems)

    @objc(removeHeldItemsObject:)
    @NSManaged public func removeFromHeldItems(_ value: HeldItems)

    @objc(addHeldItems:)
    @NSManaged public func addToHeldItems(_ values: NSSet)

    @objc(removeHeldItems:)
    @NSManaged public func removeFromHeldItems(_ values: NSSet)

}

// MARK: Generated accessors for locationAreaEncounters
extension Pokemon {

    @objc(addLocationAreaEncountersObject:)
    @NSManaged public func addToLocationAreaEncounters(_ value: LocationAreaEncounters)

    @objc(removeLocationAreaEncountersObject:)
    @NSManaged public func removeFromLocationAreaEncounters(_ value: LocationAreaEncounters)

    @objc(addLocationAreaEncounters:)
    @NSManaged public func addToLocationAreaEncounters(_ values: NSSet)

    @objc(removeLocationAreaEncounters:)
    @NSManaged public func removeFromLocationAreaEncounters(_ values: NSSet)

}

// MARK: Generated accessors for moves
extension Pokemon {

    @objc(addMovesObject:)
    @NSManaged public func addToMoves(_ value: Moves)

    @objc(removeMovesObject:)
    @NSManaged public func removeFromMoves(_ value: Moves)

    @objc(addMoves:)
    @NSManaged public func addToMoves(_ values: NSSet)

    @objc(removeMoves:)
    @NSManaged public func removeFromMoves(_ values: NSSet)

}

// MARK: Generated accessors for stats
extension Pokemon {

    @objc(addStatsObject:)
    @NSManaged public func addToStats(_ value: Stats)

    @objc(removeStatsObject:)
    @NSManaged public func removeFromStats(_ value: Stats)

    @objc(addStats:)
    @NSManaged public func addToStats(_ values: NSSet)

    @objc(removeStats:)
    @NSManaged public func removeFromStats(_ values: NSSet)

}

// MARK: Generated accessors for types
extension Pokemon {

    @objc(addTypesObject:)
    @NSManaged public func addToTypes(_ value: Types)

    @objc(removeTypesObject:)
    @NSManaged public func removeFromTypes(_ value: Types)

    @objc(addTypes:)
    @NSManaged public func addToTypes(_ values: NSSet)

    @objc(removeTypes:)
    @NSManaged public func removeFromTypes(_ values: NSSet)

}
