//
//  PokemonManager.swift
//  pokedex
//
//  Created by Admin on 4/5/21.
//

import Foundation
protocol PokemonManagerDelegate {
    func onFetchSuccess(result: [Pokemon]?)
    func onError(error: Error)
}
class PokemonManager {
    var pokemonList: [Pokemon]
    var delegate: PokemonManagerDelegate?
    init() {
        pokemonList = []
    }
    
    func fetchPokemon() {
        /*pokemonList = [Pokemon(id: 1, name: "Bulbasaur", imageUrl: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png")]*/
        performRequest(urlString: "https://pokeapi.co/api/v2/pokemon?limit=151")
        //delegate?.onFetchSuccess(result: pokemonList)
    }
    
    func performRequest(urlString: String) {
        if let fetchURl = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: fetchURl, completionHandler: handleResponse)
            task.resume()
        }
    }
    
    func handleResponse(data: Data?, urlResponse: URLResponse?, error: Error?) {
        if error != nil {
            print(error!)
            return
        }
        if let safeData = data {
            if let pokeApiResult = parseJSON(pokeApiData: safeData) {
                pokemonList = pokeApiResult.toPokemonArray()!
                delegate?.onFetchSuccess(result: pokemonList)
            }
        }
    }
    
    func parseJSON(pokeApiData: Data) -> PokeApiListResult? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(PokeApiListResult.self, from: pokeApiData)
            return decodedData
            
        } catch {
            delegate?.onError(error: error)
            print(error)
        }
        
        return nil
    }
}
