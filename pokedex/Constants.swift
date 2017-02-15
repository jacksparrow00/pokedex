//
//  Model.swift
//  pokedex
//
//  Created by Nitish on 06/02/17.
//  Copyright © 2017 Nitish. All rights reserved.
//

import Foundation
extension PokeApiClient{
    struct PokeApiAbilitiesConstants{
        static var abilities = "abilities"
        static var slot = "slot"
        static var isHidden = "is_hidden"
        static var name = "name"
        static var ability = "ability"
    }
    
    struct PokeApiStatsConstants {
        static var stats = "stats"
        static var stat = "stat"
        static var name = "name"
        static var effort = "effort"
        static var baseStat = "base_stat"
    }
    
    struct PokeApiMovesConstants {
        static var moves = "moves"
        static var move = "move"
        static var name = "name"
    }
    
    struct PokeApiPhotosConstants {
        static var sprites = "sprites"
        static var frontDefault = "front_default"
    }
    
    struct PokeApiHeldItemsConstants {
        static var heldItems = "held_items"
        static var item = "item"
        static var name = "name"
    }
    
    struct PokeApiLocationEncounterConstants {
        static var locationAreaEncounters = "location_area_encounters"
        static var name = "name"
        static var locationArea = "location_area"
    }
    
    struct PokeApiDetailsConstants {
        static var name = "name"
        static var weight = "weight"
        static var height = "height"
        static var isDefault = "is_default"
        static var id = "id"
        static var baseExperience = "base_experience"
        static var order = "order"
    }
    
    struct PokeApiTypeConstants {
        static var types = "types"
        static var slot = "slot"
        static var type = "type"
        static var name = "name"
    }
    
}
