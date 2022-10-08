//
//  HomeCoordinatorMock.swift
//  PokedexTests
//
//  Created by André Luis Barbosa Coutinho on 08/10/22.
//
import UIKit
@testable import Pokedex

final class HomeCoordinatorMock: HomeCoordinator {

    var started = false
    var numberOfCallsGoToDetails = 0
    var numberOfCallsShowAbilityInfoModal = 0

    override func start() {
        started = true
    }

    override func goToDetails(id _: String) {
        numberOfCallsGoToDetails += 1
    }

    override func showAbilityInfoModal(id _: String, abilityName _: String) {
        numberOfCallsShowAbilityInfoModal += 1
    }
}

