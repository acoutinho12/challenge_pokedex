//
//  PokemonDetailsTests.swift
//  PokedexTests
//
//  Created by André Luis Barbosa Coutinho on 08/10/22.
//

import XCTest
@testable import Pokedex

class PokemonDetailsTests: XCTestCase {
    var pokemonDetails: Any?
    var helper: PokemonMockHelpers?
    override func setUp() {
        super.setUp()
        helper = PokemonMockHelpers()
        pokemonDetails = helper?.pokemonDetails
    }

    override func tearDown() {
        pokemonDetails = nil
        helper = nil
        super.tearDown()
    }

    func test_create_PokemonDetails_Model() {
        XCTAssertTrue(pokemonDetails is PokemonDetails)
    }
}
