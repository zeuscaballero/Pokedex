//
//  PokemonController.swift
//  Pokedex
//
//  Created by zeus on 12/20/16.
//  Copyright © 2016 justzeus. All rights reserved.
//

import Foundation

class PokemonController{
    
    static func fetchPokemon(withSearchTerm searchTerm: String, completion: @escaping (Pokemon?) -> Void){
        
        let baseURL = "http://pokeapi.co/api/v2/pokemon/"
        
        //let spriteURL = "
        
        guard let url = URL(string: baseURL + "\(searchTerm.lowercased())") else {return}
        
        
        NetworkController.performRequest(for: url, httpMethod: .get) { (data, error) in
            if let error = error
            {
                print("Unable to perform URL request: \(error)")
            }
            
    /*      SERIALIZATION ALL IN ONE GUARD STATEMENT
             
             guard let data = data,
            let jsonDictionary = (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)) as? [String:AnyObject],
                let pokemon = Pokemon(dictionary: jsonDictionary) else {
                    completion(nil)
                    return
            } */
            
            
            
            //Steps to take if we get data back
            // 1) unwrap the data
            guard let data = data else {
                completion(nil)
                return
            }
            //2) Serialize our data so we can use it
            guard let serializedData = (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)) else {
                completion(nil)
                return
            }
            
            // 3) Cast our serializedData as the type it needs to be
            guard let jsonDictionary = serializedData as? [String:AnyObject] else {
                completion(nil)
                return
            }
            
            // 4) Parse out json to get to the data we need (we dont need to do this in this particular app, but this is where we would do it)
            
            // 5) Pass the dictionary that contains the information we need into our failable initializer to create our object(s)
            
            guard let pokemon = Pokemon(dictionary: jsonDictionary) else {
                completion(nil)
                return
            }
            
            //6) Call your completion handler and pass in the object(s) that you just created using the data you got back from the network call
            completion(pokemon)
        }
    }
}
