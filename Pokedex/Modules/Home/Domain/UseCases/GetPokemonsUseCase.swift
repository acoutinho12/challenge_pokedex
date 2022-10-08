//
//  GetPokemonsUseCase.swift
//  Pokedex
//
//  Created by André Luis Barbosa Coutinho on 05/10/22.
//

import Foundation

class GetPokemonsUseCase: UseCase {
    let repository: PokemonRepository
    typealias Params = String?
    typealias ReturnType = Result<Pokemon, Error>

    init(repository: PokemonRepository) {
        self.repository = repository
    }

    func execute(params next: Params = nil, completion: @escaping (ReturnType) -> Void) {
        var nextURL: String?
        if let next = next {
            nextURL = next.replacingOccurrences(of: Urls.pokemonBaseURL, with: "")
        }
        repository.getPokemons(next: nextURL) { result in
            completion(result)
        }
    }
}
