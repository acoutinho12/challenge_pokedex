//
//  PokemonCollectionView.swift
//  Pokedex
//
//  Created by André Luis Barbosa Coutinho on 05/10/22.
//
import RxCocoa
import RxSwift
import UIKit

class PokemonCollectionView: UICollectionView {


    typealias Element = [PokemonResult]

    private var pokemons:Element = []

    init() {
        super.init(frame: CGRect(), collectionViewLayout: UICollectionViewFlowLayout())
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    private func setup() {
        register(PokemonCollectionViewCell.self,
                 forCellWithReuseIdentifier: PokemonCollectionViewCell.forCellWithReuseIdentifier)
        delegate = self
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 4
        setCollectionViewLayout(layout, animated: true)
    }

    func setPokemons() {
        reloadData()
    }
}

extension PokemonCollectionView: RxCollectionViewDataSourceType {
    func collectionView(_: UICollectionView, observedEvent: Event<[PokemonResult]>) {
        pokemons = observedEvent.element ?? []
        reloadData()
    }
}

extension PokemonCollectionView: UICollectionViewDataSource {
    func collectionView(_: UICollectionView, numberOfItemsInSection _: Int) -> Int {
        pokemons.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView
            .dequeueReusableCell(withReuseIdentifier: PokemonCollectionViewCell.forCellWithReuseIdentifier, for: indexPath) as? PokemonCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.setup(pokemon: pokemons[indexPath.row])
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
        return CGSize(width: widthPerItem - 8, height: 250)
    }
}
