//
//  PokemonDetailsViewModelTests.swift
//  PokedexTests
//
//  Created by André Luis Barbosa Coutinho on 08/10/22.
//

import XCTest
@testable import Pokedex

class PokemonDetailsViewModelTests: XCTestCase {
    var viewModel: PokemonDetailsViewModel?
    var getPokemonDetailsUseCase: GetPokemonDetailsUseCaseMock?
    var getPokemonEvolutionChainUseCase: GetPokemonEvolutionChainUseCaseMock?
    var coordinator: HomeCoordinatorMock?
    var repository: PokemonRepositorySuccessMock?

    override func setUp() {
        super.setUp()
        repository = PokemonRepositorySuccessMock()
        getPokemonDetailsUseCase = GetPokemonDetailsUseCaseMock(repository: repository!)
        getPokemonEvolutionChainUseCase = GetPokemonEvolutionChainUseCaseMock(repository: repository!)
        coordinator = HomeCoordinatorMock(navigationController: UINavigationController(), repository: repository!)

        viewModel = PokemonDetailsViewModel(getPokemonDetailsUseCase: getPokemonDetailsUseCase!, getPokemonEvolutionChainUseCase: getPokemonEvolutionChainUseCase!, id: "1",
                                            coordinator: coordinator!)
    }

    override func tearDown() {
        getPokemonDetailsUseCase = nil
        getPokemonEvolutionChainUseCase = nil
        coordinator = nil
        viewModel = nil
        repository = nil
        super.tearDown()
    }

    func test_get_pokemons_details_and_evolution_chain_was_called() {
        viewModel?.viewDidLoad()
        XCTAssertEqual(getPokemonDetailsUseCase?.numberOfCalls, 1)
        XCTAssertEqual(getPokemonEvolutionChainUseCase?.numberOfCalls, 1)
    }

    func test_showAbilityInfoModal_was_called() {
        viewModel?.showAbilityInfoModal(id: "1", abilityName: "Overgrow")
        XCTAssertEqual(coordinator?.numberOfCallsShowAbilityInfoModal, 1)
    }
}


