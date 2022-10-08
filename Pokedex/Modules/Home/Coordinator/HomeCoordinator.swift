//
//  HomeCoordinator.swift
//  Pokedex
//
//  Created by André Luis Barbosa Coutinho on 05/10/22.
//

import Foundation
import UIKit

class HomeCoordinator: Coordinator {
    var navigationController: UINavigationController?

    private let repository: PokemonRepository

    init(navigationController: UINavigationController, repository: PokemonRepository) {
        self.navigationController = navigationController
        self.repository = repository
    }

    func start() {
        let getPokemonsUseCase = GetPokemonsUseCase(repository: repository)
        let viewModel = PokemonViewModel(getPokemonsUseCase: getPokemonsUseCase, coordinator: self)
        let viewController = PokemonViewController(viewModel: viewModel)
        navigationController?.setViewControllers([viewController], animated: true)
    }

    func goToDetails(id: String) {
        let getPokemonDetailsUseCase = GetPokemonDetailsUseCase(repository: repository)
        let getPokemonEvolutionChain = GetPokemonEvolutionChainUseCase(repository: repository)
        let viewModel = PokemonDetailsViewModel(getPokemonDetailsUseCase: getPokemonDetailsUseCase, getPokemonEvolutionChainUseCase: getPokemonEvolutionChain, id: id,
                                                coordinator: self)
        let viewController = PokemonDetailsViewController(viewModel: viewModel)
        navigationController?.pushViewController(viewController, animated: true)
    }

    func showAbilityInfoModal(id: String, abilityName: String) {
        let getPokemonAbilityDetailsUseCase = GetPokemonAbilityDetailsUseCase(repository: repository)
        let viewModel = PokemonAbilityDetailsViewModel(getPokemonAbilityDetailsUseCase: getPokemonAbilityDetailsUseCase, id: id)
        let viewController = PokemonAbilityDetailsViewController(viewModel: viewModel, abilityName: abilityName)
        navigationController?.present(viewController, animated: true)
    }
}
