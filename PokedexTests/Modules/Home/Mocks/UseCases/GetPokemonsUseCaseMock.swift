//
//  GetPokemonsUseCaseMock.swift
//  PokedexTests
//
//  Created by André Luis Barbosa Coutinho on 08/10/22.
//
@testable import Pokedex

final class GetPokemonsUseCaseMock: GetPokemonsUseCase {
    var numberOfCalls = 0

    override func execute(params _: Params = nil, completion _: @escaping (ReturnType) -> Void) {
        numberOfCalls += 1
    }
}
