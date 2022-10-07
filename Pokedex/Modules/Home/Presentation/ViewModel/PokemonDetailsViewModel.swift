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
}

final class PokemonDetailsViewModel: PokemonDetailsViewModelProtocol {
    var pokemonDetails = PublishSubject<PokemonDetails>()
    var pokemonEvolutionChain = PublishSubject<PokemonEvolutionChain>()
    private let getPokemonDetailsUseCase: GetPokemonDetailsUseCase
    private let getPokemonEvolutionChainUseCase: GetPokemonEvolutionChainUseCase
    private let id: String

    init(getPokemonDetailsUseCase: GetPokemonDetailsUseCase, getPokemonEvolutionChainUseCase: GetPokemonEvolutionChainUseCase, id: String) {
        self.getPokemonDetailsUseCase = getPokemonDetailsUseCase
        self.getPokemonEvolutionChainUseCase = getPokemonEvolutionChainUseCase
        self.id = id
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
}
