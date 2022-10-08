//
//  PokemonAbilityDetailsViewModel.swift
//  Pokedex
//
//  Created by André Luis Barbosa Coutinho on 07/10/22.
//

import Foundation
import RxCocoa
import RxSwift

protocol PokemonAbilityDetailsViewModelProtocol: ViewModel {
    func getPokemonAbilityDetails()
}

final class PokemonAbilityDetailsViewModel: PokemonAbilityDetailsViewModelProtocol {
    var coordinator: Coordinator?

    var pokemonAbilityDetailsDetails = PublishSubject<PokemonAbilityDetails>()
    private let getPokemonAbilityDetailsUseCase: GetPokemonAbilityDetailsUseCase
    private let id: String

    init(getPokemonAbilityDetailsUseCase: GetPokemonAbilityDetailsUseCase, id: String) {
        self.getPokemonAbilityDetailsUseCase = getPokemonAbilityDetailsUseCase
        self.id = id
    }

    func viewDidLoad() {
        getPokemonAbilityDetails()
    }

    func getPokemonAbilityDetails() {
        getPokemonAbilityDetailsUseCase.execute(params: id) { [weak self] result in
            switch result {
            case let .success(pokemonAbilityDetailsDetails):
                self?.pokemonAbilityDetailsDetails.onNext(pokemonAbilityDetailsDetails)
                self?.pokemonAbilityDetailsDetails.onCompleted()
            case let .failure(error):
                return
            }
        }
    }
}
