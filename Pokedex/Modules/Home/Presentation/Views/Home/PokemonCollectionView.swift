//
//  PokemonCollectionView.swift
//  Pokedex
//
//  Created by André Luis Barbosa Coutinho on 05/10/22.
//
import RxCocoa
import RxSwift
import UIKit

class PokemonCollectionView: UICollectionViewController {
    private var pokemons: [PokemonResult] = []
    private var pokemonsFiltered: [PokemonResult] = []
    private let disposeBag = DisposeBag()

    private var viewModel: PokemonViewModel?
    private var loadingView = LoadingView()

    init(viewModel: PokemonViewModel?) {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
        self.viewModel = viewModel
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    private func setPokemons(pokemons: [PokemonResult]) {
        self.pokemons.append(contentsOf: pokemons)
        pokemonsFiltered = self.pokemons
        collectionView.reloadData()
        removeLoadingScreen()
    }

    private func getPokemons() -> [PokemonResult] {
        !pokemonsFiltered.isEmpty ? pokemonsFiltered : pokemons
    }

    func filterData(text: String) {
        guard !text.isEmpty == true else {
            pokemonsFiltered = pokemons
            collectionView.reloadData()
            return
        }
        pokemonsFiltered = pokemons.filter {
            if $0.name.lowercased().contains(text.lowercased()) || $0.getPokemonID() == text.lowercased() {
                return true
            } else {
                return false
            }
        }
        collectionView.reloadData()
    }

    private func setup() {
        collectionView.backgroundColor = Colors.primaryBackgroundColor
        collectionView.register(PokemonCollectionViewCell.self,
                                forCellWithReuseIdentifier: PokemonCollectionViewCell.forCellWithReuseIdentifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        let layout = UICollectionViewFlowLayout()
        layout.sectionInsetReference = .fromSafeArea
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 4
        collectionView.setCollectionViewLayout(layout, animated: true)

        if let viewModel = viewModel {
            viewModel.pokemons.subscribe(onNext: { [weak self] in
                self?.setPokemons(pokemons: $0)
            }).disposed(by: disposeBag)
        }
    }

    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height

        if offsetY > contentHeight - scrollView.frame.size.height, !getPokemons().isEmpty, !(viewModel?.isFetching ?? true), pokemonsFiltered.count == pokemons.count {
            viewModel?.getNextPokemons()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setLoadingScreen()
    }

    private func setLoadingScreen() {
        collectionView.addSubview(loadingView)
    }

    private func removeLoadingScreen() {
        loadingView.stop()
    }
}

extension PokemonCollectionView {
    override func collectionView(_: UICollectionView, numberOfItemsInSection _: Int) -> Int {
        let pokemonsCell = getPokemons()
        if pokemonsFiltered.isEmpty && pokemons.isEmpty || pokemonsFiltered.isEmpty && !pokemons.isEmpty, !(viewModel?.isFetching ?? true) {
            setEmptyPokemon()
            return 0
        } else {
            restore()
        }
        return pokemonsCell.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView
            .dequeueReusableCell(withReuseIdentifier: PokemonCollectionViewCell.forCellWithReuseIdentifier, for: indexPath) as? PokemonCollectionViewCell else {
            return UICollectionViewCell()
        }
        let index = indexPath.row
        let pokemonsCell = getPokemons()
        cell.setup(pokemon: pokemonsCell[index], tag: index)
        return cell
    }
}

extension PokemonCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_: UICollectionView,
                        layout _: UICollectionViewLayout,
                        insetForSectionAt _: Int)
        -> UIEdgeInsets {
        UIEdgeInsets(top: 1.0, left: 8.0, bottom: 1.0, right: 8.0)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt _: IndexPath)
        -> CGSize {
        guard let layout = collectionViewLayout as? UICollectionViewFlowLayout else { return CGSize() }
        let widthPerItem = collectionView.frame.width / 2 - layout.minimumInteritemSpacing
        return CGSize(width: widthPerItem - 8, height: 200)
    }

    override func collectionView(_: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let id = pokemonsFiltered[indexPath.row].getPokemonID() else { return }
        viewModel?.goToDetails(id: id)
    }
}

extension PokemonCollectionView {
    func setEmptyPokemon() {
        let messageLabel = TitleSolidLabel(frame: CGRect(x: 0, y: 0, width: collectionView.bounds.size.width, height: collectionView.bounds.size.height))
        messageLabel.text = "Nenhum pokemon encontrado"
        messageLabel.textColor = .black
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.font = UIFont(name: "TrebuchetMS", size: 15)
        messageLabel.sizeToFit()

        collectionView.backgroundView = messageLabel
    }

    func restore() {
        collectionView.backgroundView = nil
    }
}
