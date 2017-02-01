//
//  PokemonModel.swift
//  pokedex
//
//  Created by Nevres on 31/01/17.
//  Copyright © 2017 mac. All rights reserved.
//

import UIKit

class PokemonModel: NSObject {

    fileprivate var _name: String!
    fileprivate var _pokedexID: Int!
    
    var name:  String {
        
        return _name
    }
    
    var pokedexID: Int {
        
        return _pokedexID
    }
    
    init(name: String, pokedexID: Int) {
        
        self._name = name
        self._pokedexID = pokedexID
    }
}
