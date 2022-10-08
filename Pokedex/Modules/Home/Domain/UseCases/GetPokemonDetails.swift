//
//  GetPokemonDetails.swift
//  Pokedex
//
//  Created by André Luis Barbosa Coutinho on 06/10/22.
//

import Foundation

class GetPokemonDetailsUseCase: UseCase {
    let repository: PokemonRepository
    typealias Params = String
    typealias ReturnType = Result<PokemonDetails, Error>

    init(repository: PokemonRepository) {
        self.repository = repository
    }

    func execute(params id: Params, completion: @escaping (ReturnType) -> Void) {
        repository.getPokemonDetails(id: id) { result in
            completion(result)
        }
    }
}
