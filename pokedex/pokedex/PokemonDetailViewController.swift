//
//  PokemonDetailViewController.swift
//  pokedex
//
//  Created by Nevres on 02/02/17.
//  Copyright © 2017 mac. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController {
    
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var segment: UISegmentedControl!
    @IBOutlet weak var mainImg: UIImageView!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var typeLbl: UILabel!
    @IBOutlet weak var defenseLbl: UILabel!
    @IBOutlet weak var heightLbl: UILabel!
    @IBOutlet weak var weightLbl: UILabel!
    @IBOutlet weak var pokeIDLbl: UILabel!
    @IBOutlet weak var attackLbl: UILabel!
    @IBOutlet weak var evolutionLbl: UILabel!
    @IBOutlet weak var evoImg1: UIImageView!
    @IBOutlet weak var evoImg2: UIImageView!
    
    
    
    var pokemon: PokemonModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLbl.text = pokemon.name
    }

    @IBAction func bckBtnPressed(_ sender: UIButton) {
        
       _ = navigationController?.popViewController(animated: true)
        
    }
    

}
