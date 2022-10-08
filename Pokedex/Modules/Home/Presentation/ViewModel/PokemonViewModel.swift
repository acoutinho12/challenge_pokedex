//
//  PokemonViewModel.swift
//  Pokedex
//
//  Created by André Luis Barbosa Coutinho on 05/10/22.
//

import Foundation
import RxCocoa
import RxSwift

protocol PokemonViewModelProtocol: ViewModel {
    func getPokemons()
    func goToDetails(id: String)
}

final class PokemonViewModel: PokemonViewModelProtocol {
    var coordinator: Coordinator?

    var isFetching = true
    var next: String?

    var pokemons = PublishSubject<[PokemonResult]>()
    private let getPokemonsUseCase: GetPokemonsUseCase

    init(getPokemonsUseCase: GetPokemonsUseCase, coordinator: HomeCoordinator) {
        self.getPokemonsUseCase = getPokemonsUseCase
        self.coordinator = coordinator
    }

    func viewDidLoad() {
        getPokemons()
    }

    func getNextPokemons() {
        isFetching = true
        if next != nil {
            getPokemons()
        }
    }

    func getPokemons() {
        getPokemonsUseCase.execute(params: next) { [weak self] pokemons in
            self?.isFetching = false
            switch pokemons {
            case let .success(pokemons):
                self?.next = pokemons.next
                self?.pokemons.onNext(pokemons.results)
                if self?.next == nil {
                    self?.pokemons.onCompleted()
                }
            case let .failure(error):
                return
            }
        }
    }

    func goToDetails(id: String) {
        (coordinator as? HomeCoordinator)?.goToDetails(id: id)
    }
}
