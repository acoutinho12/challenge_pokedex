//
//  PokemonDetailsViewModel.swift
//  Pokedex
//
//  Created by André Luis Barbosa Coutinho on 06/10/22.
//

import Foundation
import RxCocoa
import RxSwift

protocol PokemonDetailsViewModelProtocol: ViewModel {
    func getPokemonDetails()
    func getPokemonEvolutionChain()
    func showAbilityInfoModal(id: String, abilityName: String)
}

final class PokemonDetailsViewModel: PokemonDetailsViewModelProtocol {
    var coordinator: Coordinator?

    var pokemonDetails = PublishSubject<PokemonDetails>()
    var pokemonEvolutionChain = PublishSubject<PokemonEvolutionChain>()
    private let getPokemonDetailsUseCase: GetPokemonDetailsUseCase
    private let getPokemonEvolutionChainUseCase: GetPokemonEvolutionChainUseCase
    private let id: String

    init(getPokemonDetailsUseCase: GetPokemonDetailsUseCase, getPokemonEvolutionChainUseCase: GetPokemonEvolutionChainUseCase, id: String, coordinator: HomeCoordinator) {
        self.getPokemonDetailsUseCase = getPokemonDetailsUseCase
        self.getPokemonEvolutionChainUseCase = getPokemonEvolutionChainUseCase
        self.id = id
        self.coordinator = coordinator
    }

    func viewDidLoad() {
        getPokemonDetails()
        getPokemonEvolutionChain()
    }

    func getPokemonDetails() {
        getPokemonDetailsUseCase.execute(params: id) { [weak self] result in
            switch result {
            case let .success(pokemonDetails):
                self?.pokemonDetails.onNext(pokemonDetails)
                self?.pokemonDetails.onCompleted()
            case let .failure(error):
                return
            }
        }
    }

    func getPokemonEvolutionChain() {
        getPokemonEvolutionChainUseCase.execute(params: id) { [weak self] result in
            switch result {
            case let .success(pokemonEvolutionChain):
                self?.pokemonEvolutionChain.onNext(pokemonEvolutionChain)
                self?.pokemonEvolutionChain.onCompleted()
            case let .failure(error):
                return
            }
        }
    }

    func showAbilityInfoModal(id: String, abilityName: String) {
        (coordinator as? HomeCoordinator)?.showAbilityInfoModal(id: id, abilityName: abilityName)
    }
}
