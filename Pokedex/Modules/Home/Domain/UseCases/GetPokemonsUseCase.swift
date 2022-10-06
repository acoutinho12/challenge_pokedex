//
//  GetPokemonsUseCase.swift
//  Pokedex
//
//  Created by André Luis Barbosa Coutinho on 05/10/22.
//

import Foundation

final class GetPokemonsUseCase: UseCase {
    private let repository: PokemonRepository
    typealias Params = Any?
    typealias ReturnType = Result<Pokemon, Error>

    init(repository: PokemonRepository) {
        self.repository = repository
    }

    func execute(params _: Params = nil, completion: @escaping (ReturnType) -> Void) {
        repository.getPokemons { result in
            completion(result)
        }
    }
}
