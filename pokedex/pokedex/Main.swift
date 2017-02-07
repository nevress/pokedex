//
//  Main.swift
//  pokedex
//
//  Created by Nevres on 31/01/17.
//  Copyright © 2017 mac. All rights reserved.
//

import UIKit
import AVFoundation

class Main: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate  {
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collection: UICollectionView!
    @IBOutlet weak var noPokeLbl: UILabel!
    
    var pokemon = [PokemonModel]()
    var filteredPokemon = [PokemonModel]()
    var musicPlayer: AVAudioPlayer!
    //    var inSearchMode = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collection.dataSource = self
        collection.delegate = self
        searchBar.delegate = self
        
        searchBar.returnKeyType = UIReturnKeyType.done
        
        parsePokemonCSV()
        initAudio()
        filteredPokemon = pokemon
        
        //        NotificationCenter.default.addObserver(self, selector: #selector(action_detail(notification:)), name: Constants.pokemonDetailNotification, object: nil)
        self.collection.register(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "Cell")
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        
        self.navigationController?.navigationBar.isHidden = true
        
    }
    
    
    
    func initAudio() {
        
        let path = Bundle.main.path(forResource: "music", ofType: "mp3")!
        
        do {
            
            musicPlayer = try AVAudioPlayer(contentsOf: URL(string: path)!)
            musicPlayer.prepareToPlay()
            musicPlayer.numberOfLoops = -1 //nonstop loop
            musicPlayer.play()
            
        } catch let err as NSError {
            
            print(err.debugDescription)
        }
        
    }
    
    func parsePokemonCSV() {
        
        let path = Bundle.main.path(forResource: "pokemon", ofType: "csv")!
        
        do {
            
            let csv = try CSV(contentsOfURL: path)
            let rows = csv.rows
            print(rows)
            
            for row in rows {
                
                let pokeId = Int(row["id"]!)!
                let name = row["identifier"]!
                
                let poke = PokemonModel(name: name, pokedexID: pokeId)
                pokemon.append(poke)
            }
            
        } catch let err as NSError {
            
            print(err.debugDescription)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? CollectionViewCell {
            
            let poke: PokemonModel!
            poke = filteredPokemon[indexPath.row]
            cell.configureCell(pokemon: poke)
            
            
            return cell
            
        } else {
            
            return UICollectionViewCell()
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        var poke: PokemonModel!
        poke = filteredPokemon[indexPath.row]
        let controller = PokemonDetailViewController()
        controller.pokemon = poke
        self.navigationController?.pushViewController(controller, animated: true)
        
    }
    
    func action_detail(notification: Notification) {
        
        let controller = PokemonDetailViewController()
        controller.pokemon = notification.object as! PokemonModel
        navigationController?.pushViewController(controller, animated: true)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return filteredPokemon.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 105, height: 105)
        
    }
    
    @IBAction func musicBtnPressed(_ sender: UIButton) {
        
        if musicPlayer.isPlaying{
            
            musicPlayer.pause()
            sender.alpha = 0.2
        } else {
            
            musicPlayer.play()
            sender.alpha = 1.0
            
        }
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        view.endEditing(true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredPokemon.removeAll()
        if searchBar.text == nil || searchBar.text == "" {
            filteredPokemon = pokemon
        } else {
            let lower = searchBar.text!.lowercased()
            filteredPokemon = pokemon.filter({$0.name.range(of: lower) != nil})
            
            //            for poke in pokemon {
            //                if poke.name.lowercased().contains((searchBar.text?.lowercased())!)  {
            //                    filteredPokemon.append(poke)
            //                }
            //            }
            
            
        }
        collection.reloadData()
        if filteredPokemon.count == 0 {
            noPokeLbl.isHidden = false
            noPokeLbl.alpha = 0.0
            UIView.animate(withDuration: 1, animations: {
                self.noPokeLbl.alpha = 1.0
            })
        } else {
            noPokeLbl.isHidden = true
        }
        
        
    }
    
    
    
}
