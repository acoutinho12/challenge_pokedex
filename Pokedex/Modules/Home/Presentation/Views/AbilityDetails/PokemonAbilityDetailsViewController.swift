//
//  PokemonAbilityDetailsViewController.swift
//  Pokedex
//
//  Created by André Luis Barbosa Coutinho on 07/10/22.
//

import ImageSlideshow
import RxCocoa
import RxSwift
import UIKit

final class PokemonAbilityDetailsViewController: UIViewController, ViewController {
    var coordinator: Coordinator?
    var viewModel: ViewModel?

    private let disposeBag = DisposeBag()

    init(coordinator: HomeCoordinator, viewModel: PokemonAbilityDetailsViewModel) {
        self.coordinator = coordinator
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.viewDidLoad()
        view.backgroundColor = .white
    }
}
