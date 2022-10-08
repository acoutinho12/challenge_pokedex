//
//  PokemonAbilityDetailsTests.swift
//  PokedexTests
//
//  Created by André Luis Barbosa Coutinho on 08/10/22.
//

import XCTest
@testable import Pokedex

class PokemonAbilityDetailsTests: XCTestCase {
    var pokemonAbilityDetails: Any?
    var helper: PokemonMockHelpers?
    override func setUp() {
        super.setUp()
        helper = PokemonMockHelpers()
        pokemonAbilityDetails = helper?.pokemonAbilityDetails
    }

    override func tearDown() {
        pokemonAbilityDetails = nil
        helper = nil
        super.tearDown()
    }

    func test_create_PokemonAbilityDetails_Model() {
        XCTAssertTrue(pokemonAbilityDetails is PokemonAbilityDetails)
    }
}

