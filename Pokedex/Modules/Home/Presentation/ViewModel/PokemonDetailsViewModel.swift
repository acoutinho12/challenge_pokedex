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
}

final class PokemonDetailsViewModel: PokemonDetailsViewModelProtocol {
    var pokemonDetails = PublishSubject<PokemonDetails>()
    private let getPokemonDetailsUseCase: GetPokemonDetailsUseCase
    private let id: String

    init(getPokemonDetailsUseCase: GetPokemonDetailsUseCase, id: String) {
        self.getPokemonDetailsUseCase = getPokemonDetailsUseCase
        self.id = id
    }

    func viewDidLoad() {
        getPokemonDetails()
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
}
