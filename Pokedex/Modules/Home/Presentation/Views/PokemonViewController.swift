//
//  PokemonViewController.swift
//  Pokedex
//
//  Created by André Luis Barbosa Coutinho on 05/10/22.
//

import RxCocoa
import RxSwift
import UIKit

final class PokemonViewController: UIViewController, ViewController {
    var coordinator: Coordinator?
    var viewModel: ViewModel?
    private let bag = DisposeBag()

    init(coordinator: HomeCoordinator, viewModel: PokemonViewModel) {
        self.coordinator = coordinator
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    private lazy var pokemonCollectionView: PokemonCollectionView = .init()

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.viewDidLoad()
        view.backgroundColor = .white
        (viewModel as? PokemonViewModel)?.pokemons.bind(to: pokemonCollectionView.rx.items(dataSource: pokemonCollectionView.self)).disposed(by: bag)

        view = pokemonCollectionView

        addSubViews()
        configureSubViews()
        configureConstraints()
    }

    func addSubViews() {}

    func configureSubViews() {}

    func configureConstraints() {}

    func handle(error _: Error) {}
}
