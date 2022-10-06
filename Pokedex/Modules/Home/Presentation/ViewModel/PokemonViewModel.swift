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
}

final class PokemonViewModel: PokemonViewModelProtocol {
    var pokemons = PublishSubject<[PokemonResult]>()
    private let getPokemonsUseCase: GetPokemonsUseCase

    init(getPokemonsUseCase: GetPokemonsUseCase) {
        self.getPokemonsUseCase = getPokemonsUseCase
    }

    func viewDidLoad() {
        getPokemons()
    }

    func getPokemons() {
        getPokemonsUseCase.execute { pokemons in
            switch pokemons {
            case let .success(pokemons):
                self.pokemons.onNext(pokemons.results)
                self.pokemons.onCompleted()
            case let .failure(error):
                return
            }
        }
    }
}
