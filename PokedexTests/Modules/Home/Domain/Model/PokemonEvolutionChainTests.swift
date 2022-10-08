//
//  PokemonEvolutionChainTests.swift
//  PokedexTests
//
//  Created by André Luis Barbosa Coutinho on 08/10/22.
//

import XCTest
@testable import Pokedex

class PokemonEvolutionChainTests: XCTestCase {
    var pokemonEvolutionChain: Any?
    var helper: PokemonMockHelpers?
    override func setUp() {
        super.setUp()
        helper = PokemonMockHelpers()
        pokemonEvolutionChain = helper?.pokemonEvolutionChain
    }

    override func tearDown() {
        pokemonEvolutionChain = nil
        helper = nil
        super.tearDown()
    }

    func test_create_PokemonEvolutionChainTests_Model() {
        XCTAssertTrue(pokemonEvolutionChain is PokemonEvolutionChain)
    }
}


