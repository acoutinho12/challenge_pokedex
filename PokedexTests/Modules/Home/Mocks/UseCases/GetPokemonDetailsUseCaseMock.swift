//
//  GetPokemonDetailsUseCaseMock.swift
//  PokedexTests
//
//  Created by André Luis Barbosa Coutinho on 08/10/22.
//

@testable import Pokedex

final class GetPokemonDetailsUseCaseMock: GetPokemonDetailsUseCase {
    var numberOfCalls = 0

    override func execute(params _: GetPokemonDetailsUseCase.Params, completion _: @escaping (GetPokemonDetailsUseCase.ReturnType) -> Void) {
        numberOfCalls += 1
    }
}

