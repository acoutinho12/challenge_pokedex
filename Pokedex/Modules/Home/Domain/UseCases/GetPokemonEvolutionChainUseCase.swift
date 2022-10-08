//
//  GetPokemonEvolutionChainUseCase.swift
//  Pokedex
//
//  Created by André Luis Barbosa Coutinho on 07/10/22.
//

import Foundation

class GetPokemonEvolutionChainUseCase: UseCase {
    let repository: PokemonRepository
    typealias Params = String
    typealias ReturnType = Result<PokemonEvolutionChain, Error>

    init(repository: PokemonRepository) {
        self.repository = repository
    }

    func execute(params id: Params, completion: @escaping (ReturnType) -> Void) {
        repository.getPokemonEvolutionChain(id: id) { result in
            completion(result)
        }
    }
}
