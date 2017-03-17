//
//  Pokemon.swift
//  Pokedex
//
//  Created by zeus on 12/20/16.
//  Copyright © 2016 justzeus. All rights reserved.
//

import Foundation
import UIKit

class Pokemon {
    
    let name: String
    let pokeID: String
    let abilities: [String]
    let spriteURLString: String
    
    private let nameKey = "name"
    private let pokeIDKey = "id"
    private let abilityKey = "abilities"
    private let abilityNameKey = "ability"
    private let spritesKey = "sprites"
    private let spriteURLKey = "front_default"
    
    init?(dictionary: [String: Any]) {
        guard let name = dictionary[nameKey] as? String,
            let pokeIDInt = dictionary[pokeIDKey] as? Int,
            let abilitiesArray = dictionary[abilityKey] as? [[String: AnyObject]],
            let spritesDictionary = dictionary[spritesKey] as? [String: Any],
            let spriteURLString = spritesDictionary[spriteURLKey] as? String
            else { return nil }
        let abilities = abilitiesArray.flatMap { $0["ability"]?["name"] as? String }
        let pokeID = String(pokeIDInt)
        
        
        self.name = name
        self.pokeID = pokeID
        self.abilities = abilities
        self.spriteURLString = spriteURLString
    }
}
