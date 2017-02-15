//
//  GCDBlackBox.swift
//  pokedex
//
//  Created by Nitish on 08/02/17.
//  Copyright © 2017 Nitish. All rights reserved.
//

import Foundation
func performUIUpdatesOnMain( updates: @escaping() -> Void){
    DispatchQueue.main.async {
        updates()
    }
    
}
