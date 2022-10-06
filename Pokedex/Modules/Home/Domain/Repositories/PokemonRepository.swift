//
//  PokemonRepository.swift
//  Pokedex
//
//  Created by André Luis Barbosa Coutinho on 05/10/22.
//

import Foundation

protocol PokemonRepository: AnyObject {
    func getPokemons(completion: @escaping(Result<Pokemon, Error>) -> Void)
}
