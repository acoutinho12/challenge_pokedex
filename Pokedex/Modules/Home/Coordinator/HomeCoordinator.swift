//
//  HomeCoordinator.swift
//  Pokedex
//
//  Created by André Luis Barbosa Coutinho on 05/10/22.
//

import Foundation
import UIKit

final class HomeCoordinator: Coordinator {
    var navigationController: UINavigationController?

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let getPokemonsUseCase = GetPokemonsUseCase(repository: PokemonRepositoryImpl(datasource: PokemonDataSourceImpl()))
        let viewModel = PokemonViewModel(getPokemonsUseCase: getPokemonsUseCase)
        let viewController = PokemonViewController(coordinator: self, viewModel: viewModel)
        navigationController?.setViewControllers([viewController], animated: true)
    }
}
