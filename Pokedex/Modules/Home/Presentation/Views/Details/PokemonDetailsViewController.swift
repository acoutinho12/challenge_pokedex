//
//  PokemonDetailsViewController.swift
//  Pokedex
//
//  Created by André Luis Barbosa Coutinho on 06/10/22.
//

import ImageSlideshow
import RxCocoa
import RxSwift
import UIKit

final class PokemonDetailsViewController: UIViewController, ViewController {
    var viewModel: ViewModel?

    private let disposeBag = DisposeBag()

    private let pokemonDetailsHeader = PokemonDetailsHeaderView()
    private let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let pokemonCarousel = PokemonCarouselView()
    private let pokemonStatsView = PokemonStatsView()
    private var pokemonAbilitiesView: PokemonAbilitiesView!
    private let pokemonEvolutionChainView = PokemonEvolutionChainView()

    private let scrollStackViewContainer: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let horizontalPillStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 32
        view.distribution = .fillEqually
        view.alignment = .center
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let headerSubView: UIView = {
        let view = UIView()
        view.heightAnchor.constraint(equalToConstant: 350).isActive = true
        view.backgroundColor = UIColor.white
        return view
    }()

    private let statsSubView: UIView = {
        let view = UIView()
        view.heightAnchor.constraint(equalToConstant: 250).isActive = true
        view.backgroundColor = UIColor.white
        return view
    }()

    private let abilitiesSubView: UIView = {
        let view = UIView()
        view.heightAnchor.constraint(equalToConstant: 130).isActive = true
        view.backgroundColor = UIColor.white
        return view
    }()

    private let evolutionChainSubView: UIView = {
        let view = UIView()
        view.heightAnchor.constraint(equalToConstant: 500).isActive = true
        view.backgroundColor = UIColor.white
        return view
    }()

    init(viewModel: PokemonDetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.viewDidLoad()
        view.backgroundColor = Colors.primaryBackgroundColor
        let backButton = UIBarButtonItem()
        backButton.title = ""
        backButton.tintColor = .white
        navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        pokemonAbilitiesView = PokemonAbilitiesView(viewModel: viewModel as? PokemonDetailsViewModel)
        addSubViews()
        configureConstraints()
        configureSubViews()
    }

    func addSubViews() {
        view.addSubview(scrollView)
        scrollView.addSubview(scrollStackViewContainer)
        headerSubView.addSubview(pokemonDetailsHeader)
        headerSubView.addSubview(horizontalPillStackView)
        headerSubView.addSubview(pokemonCarousel)
        statsSubView.addSubview(pokemonStatsView)
        abilitiesSubView.addSubview(pokemonAbilitiesView)
        evolutionChainSubView.addSubview(pokemonEvolutionChainView)
        scrollStackViewContainer.addArrangedSubview(headerSubView)
        scrollStackViewContainer.addArrangedSubview(statsSubView)
        scrollStackViewContainer.addArrangedSubview(abilitiesSubView)
    }

    func configureSubViews() {
        if let viewModel = viewModel as? PokemonDetailsViewModel {
            viewModel.pokemonDetails.subscribe(onNext: { [weak self] in
                self?.pokemonDetailsHeader.setup(pokemonDetails: $0)
                let backGroundColor = Colors.getColorBy(type: ColorsType(rawValue: $0.types?.first?.type?.name ?? "unknown") ?? .unknown)
                self?.setBackgroundColor(backGroundColor: backGroundColor)
                self?.pokemonStatsView.setTitle(color: backGroundColor, width: self?.view.frame.width ?? 0)
                if let stats = $0.stats {
                    stats.forEach {
                        self?.pokemonStatsView.setup(stat: $0, color: backGroundColor)
                    }
                }
                if let types = $0.types {
                    self?.addTypePills(types: types)
                }
                if let sprites = $0.sprites {
                    self?.configureCarousel(sprites: sprites)
                }
                if let abilities = $0.abilities {
                    self?.pokemonAbilitiesView.setup(abilities: abilities, color: backGroundColor)
                }
                self?.setEvolutionChain(backGroundColor: backGroundColor)
            }).disposed(by: disposeBag)
        }
    }

    private func setEvolutionChain(backGroundColor: UIColor) {
        if let viewModel = viewModel as? PokemonDetailsViewModel {
            viewModel.pokemonEvolutionChain.subscribe(onNext: { [weak self] in
                self?.scrollStackViewContainer.addArrangedSubview(self?.evolutionChainSubView ?? UIView())
                self?.setPokemonEvolutionChainConstraints()
                self?.pokemonEvolutionChainView.setup(evolutionChain: $0, color: backGroundColor)
            }).disposed(by: disposeBag)
        }
    }

    private func addTypePills(types: [TypeElement]) {
        let typeCount = types.count
        if typeCount <= 0 {
            return
        }
        let width = (horizontalPillStackView.frame.width / CGFloat(typeCount)) - (typeCount > 1 ? CGFloat(32 / typeCount) : 0)
        types.forEach {
            guard let species = $0.type else { return }
            let pill = PokemonTypePillView()
            pill.setup(species: species, width: width)
            horizontalPillStackView.addArrangedSubview(pill)
        }
    }

    private func configureCarousel(sprites: Sprites) {
        let encoded = try? JSONEncoder().encode(sprites)
        guard let dictionary = try? JSONSerialization.jsonObject(with: encoded!, options: .allowFragments) as? [String: Any] else {
            return
        }
        dictionary.iterateThroughAllKeyValues { [weak self] _, value in
            guard let value = value as? String else {
                return
            }
            DispatchQueue.main.async {
                self?.pokemonCarousel.configureCarousel(url: value)
            }
        }
    }

    private func setBackgroundColor(backGroundColor: UIColor) {
        scrollView.backgroundColor = backGroundColor
    }

    func configureConstraints() {
        // pokemonDetailsHeader
        pokemonDetailsHeader.translatesAutoresizingMaskIntoConstraints = false
        let height = 250.0
        let width = view.frame.width
        NSLayoutConstraint.heightConstant(view: pokemonDetailsHeader, constant: height)
        NSLayoutConstraint.widthConstant(view: pokemonDetailsHeader, constant: width)
        NSLayoutConstraint.centerX(view: pokemonDetailsHeader, superView: headerSubView)
        NSLayoutConstraint.topAnchor(view: pokemonDetailsHeader, superView: headerSubView)

        // scrollView
        NSLayoutConstraint.leadingAnchor(view: scrollView, superView: view)
        NSLayoutConstraint.trailingAnchor(view: scrollView, superView: view)
        NSLayoutConstraint.topAnchor(view: scrollView, superView: view)
        NSLayoutConstraint.bottomAnchor(view: scrollView, superView: view, isSafeArea: true)

        // scrollStackViewContainer
        NSLayoutConstraint.leadingAnchor(view: scrollStackViewContainer, superView: scrollView)
        NSLayoutConstraint.trailingAnchor(view: scrollStackViewContainer, superView: scrollView)
        NSLayoutConstraint.topAnchor(view: scrollStackViewContainer, superView: scrollView)
        NSLayoutConstraint.bottomAnchor(view: scrollStackViewContainer, superView: scrollView)
        NSLayoutConstraint.widthAnchor(view: scrollStackViewContainer, superView: scrollView)

        // horizontalPillStackView
        NSLayoutConstraint.bottomAnchor(view: horizontalPillStackView, superView: headerSubView)
        NSLayoutConstraint.heightConstant(view: horizontalPillStackView, constant: 60)
        NSLayoutConstraint.widthConstant(view: horizontalPillStackView, constant: view.frame.width * 0.8)
        NSLayoutConstraint.centerX(view: horizontalPillStackView, superView: scrollView)

        // pokemonCarousel
        pokemonCarousel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.heightConstant(view: pokemonCarousel, constant: view.frame.width * 0.48)
        NSLayoutConstraint.widthConstant(view: pokemonCarousel, constant: view.frame.width)
        NSLayoutConstraint.center(view: pokemonCarousel, superView: headerSubView)

        // pokemonStatsView
        pokemonStatsView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.heightAnchor(view: pokemonStatsView, superView: statsSubView)
        NSLayoutConstraint.widthConstant(view: pokemonStatsView, constant: view.frame.width)
        NSLayoutConstraint.center(view: pokemonStatsView, superView: statsSubView)

        // pokemonAbilitiesView
        pokemonAbilitiesView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.heightAnchor(view: pokemonAbilitiesView, superView: abilitiesSubView)
        NSLayoutConstraint.widthConstant(view: pokemonAbilitiesView, constant: view.frame.width)
        NSLayoutConstraint.center(view: pokemonAbilitiesView, superView: abilitiesSubView)
    }

    private func setPokemonEvolutionChainConstraints() {
        // pokemonEvolutionChainView
        pokemonEvolutionChainView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.heightAnchor(view: pokemonEvolutionChainView, superView: evolutionChainSubView)
        NSLayoutConstraint.widthConstant(view: pokemonEvolutionChainView, constant: view.frame.width)
        NSLayoutConstraint.center(view: pokemonEvolutionChainView, superView: evolutionChainSubView)
    }

    func handle(error _: Error) {}
}
