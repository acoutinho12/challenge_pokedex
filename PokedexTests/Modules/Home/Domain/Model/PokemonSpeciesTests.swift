//
//  PokemonSpeciesTests.swift
//  PokedexTests
//
//  Created by André Luis Barbosa Coutinho on 08/10/22.
//

import XCTest
@testable import Pokedex

class PokemonSpeciesTests: XCTestCase {
    var pokemonSpecies: Any?
    var helper: PokemonMockHelpers?
    override func setUp() {
        super.setUp()
        helper = PokemonMockHelpers()
        pokemonSpecies = helper?.pokemonSpecies
    }

    override func tearDown() {
        pokemonSpecies = nil
        helper = nil
        super.tearDown()
    }

    func test_create_PokemonSpecies_Model() {
        XCTAssertTrue(pokemonSpecies is PokemonSpecies)
    }
}



