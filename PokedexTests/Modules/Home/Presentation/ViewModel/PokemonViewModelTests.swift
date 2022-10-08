//
//  PokemonViewModelTests.swift
//  PokedexTests
//
//  Created by André Luis Barbosa Coutinho on 08/10/22.
//

import XCTest
@testable import Pokedex

class PokemonViewModelTests: XCTestCase {
    var viewModel: PokemonViewModel?
    var getPokemonsUseCase: GetPokemonsUseCaseMock?
    var coordinator: HomeCoordinatorMock?
    var repository: PokemonRepositorySuccessMock?
    override func setUp() {
        super.setUp()
        repository = PokemonRepositorySuccessMock()
        getPokemonsUseCase = GetPokemonsUseCaseMock(repository: repository!)
        coordinator = HomeCoordinatorMock(navigationController: UINavigationController(), repository: repository!)
        viewModel = PokemonViewModel(getPokemonsUseCase: getPokemonsUseCase!, coordinator: coordinator!)
    }

    override func tearDown() {
        getPokemonsUseCase = nil
        coordinator = nil
        viewModel = nil
        repository = nil
        super.tearDown()
    }

    func test_get_pokemons_was_called() {
        viewModel?.viewDidLoad()
        XCTAssertEqual(getPokemonsUseCase?.numberOfCalls, 1)
    }

    func test_go_to_details_was_called() {
        viewModel?.goToDetails(id: "1")
        XCTAssertEqual(coordinator?.numberOfCallsGoToDetails, 1)
    }

    func test_get_pokemons_was_called_when_trying_to_get_next_pokemons() {
        viewModel?.next = ""
        viewModel?.getNextPokemons()
        XCTAssertEqual(getPokemonsUseCase?.numberOfCalls, 1)
    }
}


