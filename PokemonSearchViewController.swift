//
//  PokemonSearchViewController.swift
//  Pokedex
//
//  Created by zeus on 12/20/16.
//  Copyright © 2016 justzeus. All rights reserved.
//

import UIKit

class PokemonSearchViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var pokemonIDLabel: UILabel!

    
    @IBOutlet weak var abilitiesLabel: UILabel!

    
    @IBOutlet weak var pokemonSearchBar: UISearchBar!

    
    @IBOutlet weak var pokemonImageView: UIImageView!
   
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(PokemonSearchViewController.dismissKeyboard)))
        
        pokemonSearchBar.backgroundImage = UIImage()
        
        self.nameLabel.text = nil
        self.pokemonIDLabel.text = nil
        self.abilitiesLabel.text = nil
        
        searchForPokemon()
        
    }
    
    func dismissKeyboard() {
        pokemonSearchBar.resignFirstResponder()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        pokemonSearchBar.resignFirstResponder()
        searchForPokemon()
    }
    
    func searchForPokemon() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let searchTerm = pokemonSearchBar.text != "" ? pokemonSearchBar.text! : "pikachu"
        PokemonController.fetchPokemon(withSearchTerm: searchTerm) { (pokemon) in
            DispatchQueue.main.async {
                guard let pokemon = pokemon else { return }
                ImageController.image(forURL: pokemon.spriteURLString, completion: { (image) in
                    self.pokemonImageView.image = image
                    self.nameLabel.text = pokemon.name
                    self.pokemonIDLabel.text = pokemon.pokeID
                    self.abilitiesLabel.text = "Abilities: \(pokemon.abilities.joined(separator:", "))"
                    
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                })
            }
        }
    }
}
