//
//  PokemonModel.swift
//  pokedex
//
//  Created by Nevres on 31/01/17.
//  Copyright © 2017 mac. All rights reserved.
//

import UIKit

class PokemonModel: NSObject {

    private var _name: String!
    private var _pokedexID: Int!
    private var _description: String!
    private var _type: String!
    private var _defense: String!
    private var _height: String!
    private var _weight: String!
    private var _attack: String!
    private var _nextEvolutionText: String!
    
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
