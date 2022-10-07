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
    var coordinator: Coordinator?
    var viewModel: ViewModel?

    private let disposeBag = DisposeBag()

    private let pokemonDetailsHeader = PokemonDetailsHeader()
    private let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let imageSlideshow = ImageSlideshow()

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

    private let subView1: UIView = {
        let view = UIView()
        view.heightAnchor.constraint(equalToConstant: 350).isActive = true
        view.backgroundColor = UIColor.white
        return view
    }()

    private let subview2: UIView = {
        let view = UIView()
        view.heightAnchor.constraint(equalToConstant: 300).isActive = true
        view.backgroundColor = UIColor.white
        return view
    }()

    private let subview3: UIView = {
        let view = UIView()
        view.heightAnchor.constraint(equalToConstant: 400).isActive = true
        view.backgroundColor = UIColor.white
        return view
    }()

    init(coordinator: HomeCoordinator, viewModel: PokemonDetailsViewModel) {
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
        view.backgroundColor = Colors.primaryBackgroundColor
        addSubViews()
        configureSubViews()
        configureConstraints()
    }

    func addSubViews() {
        view.addSubview(scrollView)
        scrollView.addSubview(scrollStackViewContainer)
        subView1.addSubview(pokemonDetailsHeader)
        subView1.addSubview(horizontalPillStackView)
        subView1.addSubview(imageSlideshow)
        scrollStackViewContainer.addArrangedSubview(subView1)
        scrollStackViewContainer.addArrangedSubview(subview2)
        scrollStackViewContainer.addArrangedSubview(subview3)
    }

    func configureCarousel(url: String) {
        UIImageView.loadFrom(endPoint: url, urlIsFULL: true) { [weak self] pokemonImageView in
            var images = self?.imageSlideshow.images
            guard let pokemonImage = pokemonImageView?.image else {
                return
            }
            images?.append(contentsOf: [ImageSource(image: pokemonImage)])
            self?.imageSlideshow.setImageInputs(images!)
        }
    }

    func configureSubViews() {
        if let viewModel = viewModel as? PokemonDetailsViewModel {
            viewModel.pokemonDetails.subscribe(onNext: { [weak self] in
                self?.pokemonDetailsHeader.setup(pokemonDetails: $0)
                self?.setBackgroundColor(pokemonDetails: $0)
                $0.types?.forEach {
                    guard let type = $0.type else { return }
                    self?.addTypePill(species: type)
                }
                guard let sprites = $0.sprites else {
                    return
                }
                let encoded = try? JSONEncoder().encode(sprites)
                guard let dictionary = try? JSONSerialization.jsonObject(with: encoded!, options: .allowFragments) as? [String: Any] else {
                    return
                }
                dictionary.iterateThroughAllKeyValues { _, value in
                    guard let value = value as? String else {
                        return
                    }
                    self?.configureCarousel(url: value)
                }
            }).disposed(by: disposeBag)
        }
    }

    private func addTypePill(species: Species) {
        let pill = PokemonTypePill()
        pill.setup(species: species)
        horizontalPillStackView.addArrangedSubview(pill)
    }

    private func setBackgroundColor(pokemonDetails: PokemonDetails) {
        scrollView.backgroundColor = Colors.getColorBy(type: ColorsType(rawValue: pokemonDetails.types?.first?.type?.name ?? "unknown") ?? .unknown)
    }

    func configureConstraints() {
        pokemonDetailsHeader.translatesAutoresizingMaskIntoConstraints = false
        let height = 250.0
        let width = view.frame.width

        NSLayoutConstraint.heightConstant(view: pokemonDetailsHeader, constant: height)
        NSLayoutConstraint.widthConstant(view: pokemonDetailsHeader, constant: width)

        let margins = view.layoutMarginsGuide
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: margins.bottomAnchor).isActive = true

        scrollStackViewContainer.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        scrollStackViewContainer.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        scrollStackViewContainer.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        scrollStackViewContainer.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        scrollStackViewContainer.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true

        horizontalPillStackView.bottomAnchor.constraint(equalTo: subView1.bottomAnchor).isActive = true
        horizontalPillStackView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        horizontalPillStackView.widthAnchor.constraint(equalToConstant: view.frame.width / 1.5).isActive = true
        horizontalPillStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true

        let imageSlideShowWH = view.frame.width / 2
        imageSlideshow.frame = CGRect(x: view.frame.width / 4, y: imageSlideShowWH / 2, width: imageSlideShowWH, height: imageSlideShowWH)
        imageSlideshow.pageIndicator = {
            let pageControl = UIPageControl()

            if #available(iOS 13.0, *) {
                pageControl.currentPageIndicatorTintColor = UIColor { traits in
                    traits.userInterfaceStyle == .dark ? .white : .lightGray
                }
            } else {
                pageControl.currentPageIndicatorTintColor = .lightGray
            }

            if #available(iOS 13.0, *) {
                pageControl.pageIndicatorTintColor = UIColor { traits in
                    traits.userInterfaceStyle == .dark ? .systemGray : .black
                }
            } else {
                pageControl.pageIndicatorTintColor = .systemGray
            }

            return pageControl
        }()
    }

    func handle(error _: Error) {}
}
