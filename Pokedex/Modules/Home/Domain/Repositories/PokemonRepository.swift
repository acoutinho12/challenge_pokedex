//
//  PokemonRepository.swift
//  Pokedex
//
//  Created by André Luis Barbosa Coutinho on 05/10/22.
//

import Foundation

protocol PokemonRepository: AnyObject {
    func getPokemons(next: String?, completion: @escaping(Result<Pokemon, Error>) -> Void)
    func getPokemonDetails(id: String, completion: @escaping(Result<PokemonDetails, Error>) -> Void)
}
