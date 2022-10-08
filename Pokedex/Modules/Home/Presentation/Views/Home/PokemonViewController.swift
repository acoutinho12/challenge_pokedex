//
//  PokemonViewController.swift
//  Pokedex
//
//  Created by André Luis Barbosa Coutinho on 05/10/22.
//

import UIKit

final class PokemonViewController: UIViewController, ViewController {
    var viewModel: ViewModel?

    init(viewModel: PokemonViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    private lazy var pokemonCollectionView: PokemonCollectionView = .init(viewModel: self.viewModel as? PokemonViewModel)
    private lazy var searchController = UISearchController(searchResultsController: nil)

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.viewDidLoad()
        configureSearchBar()
        addSubViews()
        configureSubViews()
        configureConstraints()
    }

    private func configureSearchBar() {
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.obscuresBackgroundDuringPresentation = false

        searchController.searchBar.sizeToFit()
        searchController.searchBar.placeholder = "Busque por ID ou Nome"
        UILabel.appearance(whenContainedInInstancesOf: [UISearchBar.self]).font = UIFont(name: "Pokemon Solid", size: 16)
        UILabel.appearance(whenContainedInInstancesOf: [UISearchBar.self]).textColor = .systemGray

        definesPresentationContext = true
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController = searchController
    }

    func addSubViews() {
        view = pokemonCollectionView.collectionView
    }

    func configureConstraints() {
        pokemonCollectionView.collectionView.translatesAutoresizingMaskIntoConstraints = false
        pokemonCollectionView.collectionView.bounds = view.bounds
    }
}

extension PokemonViewController: UISearchResultsUpdating {
    func updateSearchResults(for _: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        pokemonCollectionView.filterData(text: text)
    }
}
