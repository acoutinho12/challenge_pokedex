//
//  PokemonAbilityDetailsViewModelTests.swift
//  PokedexTests
//
//  Created by André Luis Barbosa Coutinho on 08/10/22.
//

import XCTest
@testable import Pokedex

class PokemonAbilityDetailsViewModelTests: XCTestCase {
    var viewModel: PokemonAbilityDetailsViewModel?
    var getPokemonAbilityDetailsUseCase: GetPokemonAbilityDetailsUseCaseMock?
    var coordinator: HomeCoordinatorMock?
    var repository: PokemonRepositorySuccessMock?
    override func setUp() {
        super.setUp()
        repository = PokemonRepositorySuccessMock()
        getPokemonAbilityDetailsUseCase = GetPokemonAbilityDetailsUseCaseMock(repository: repository!)
        coordinator = HomeCoordinatorMock(navigationController: UINavigationController(), repository: repository!)
        viewModel = PokemonAbilityDetailsViewModel(getPokemonAbilityDetailsUseCase: getPokemonAbilityDetailsUseCase!, id: "")
    }

    override func tearDown() {
        getPokemonAbilityDetailsUseCase = nil
        coordinator = nil
        viewModel = nil
        repository = nil
        super.tearDown()
    }

    func test_get_pokemons_ability_details_was_called() {
        viewModel?.viewDidLoad()
        XCTAssertEqual(getPokemonAbilityDetailsUseCase?.numberOfCalls, 1)
    }
}



