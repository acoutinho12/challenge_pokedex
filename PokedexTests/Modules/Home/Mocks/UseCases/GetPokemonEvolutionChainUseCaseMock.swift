//
//  GetPokemonEvolutionChainUseCaseMock.swift
//  PokedexTests
//
//  Created by André Luis Barbosa Coutinho on 08/10/22.
//

@testable import Pokedex

final class GetPokemonEvolutionChainUseCaseMock: GetPokemonEvolutionChainUseCase {

    var numberOfCalls = 0

    override func execute(params _: GetPokemonEvolutionChainUseCase.Params, completion _: @escaping (GetPokemonEvolutionChainUseCase.ReturnType) -> Void) {
        numberOfCalls += 1
    }
}

