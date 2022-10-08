//
//  HomeCoordinatorTests.swift
//  PokedexTests
//
//  Created by André Luis Barbosa Coutinho on 08/10/22.
//

import XCTest
@testable import Pokedex

class HomeCoordinatorTests: XCTestCase {
    var coordinator: HomeCoordinator?
    var navigationController: UINavigationController?
    var repository: PokemonRepositorySuccessMock?
    var window: UIWindow?
    override func setUp() {
        super.setUp()
        navigationController = UINavigationController()
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        repository = PokemonRepositorySuccessMock()
        coordinator = HomeCoordinator(navigationController: navigationController!, repository: repository!)
    }

    override func tearDown() {
        coordinator = nil
        navigationController = nil
        repository = nil
        window = nil
        super.tearDown()
    }

    func test_success_PokemonViewController_is_visible() {
        coordinator?.start()
        let viewController = navigationController?.topViewController
        XCTAssertTrue(viewController is PokemonViewController)
    }

    func test_success_PokemonDetailsViewController_is_visible() {
        coordinator?.goToDetails(id: "1")
        let viewController = navigationController?.topViewController
        XCTAssertTrue(viewController is PokemonDetailsViewController)
    }

    func test_success_PokemonAbilityDetailsViewController_is_visible() {
        coordinator?.goToDetails(id: "1")
        coordinator?.showAbilityInfoModal(id: "1", abilityName: "Overgrow")
        let viewController = navigationController?.presentedViewController
        XCTAssertTrue(viewController is PokemonAbilityDetailsViewController)
    }
}
