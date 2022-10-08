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
    var viewModel: ViewModel?
    private var abilityName: String?
    init(viewModel: PokemonAbilityDetailsViewModel, abilityName: String) {
        self.viewModel = viewModel
        self.abilityName = abilityName
        super.init(nibName: nil, bundle: nil)
        transitioningDelegate = self
        modalPresentationStyle = .custom
    }

    private let closeLabel = BodySolidLabel()
    private let abilityDetailLabel = CaptionSolidLabel()
    private let abilityNameLabel = BodySolidLabel()
    private var loadingView = LoadingView()

    private let bag = DisposeBag()

    required init?(coder: NSCoder) { super.init(coder: coder) }

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.viewDidLoad()
        view.backgroundColor = Colors.primaryBackgroundColor
        view.roundCorner([.topRight, .topLeft], radius: 16.0, borderColor: .black, borderWidth: 1)

        closeLabel.textColor = .black
        closeLabel.text = "X"
        closeLabel.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        closeLabel.addGestureRecognizer(tapGesture)
        abilityNameLabel.text = abilityName
        addSubViews()
        configureConstraints()
        configureSubViews()
    }

    func addSubViews() {
        view.addSubview(closeLabel)
        view.addSubview(abilityDetailLabel)
        view.addSubview(abilityNameLabel)
        view.addSubview(loadingView)
    }

    func configureConstraints() {
        closeLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.heightConstant(view: closeLabel, constant: 30)
        NSLayoutConstraint.widthConstant(view: closeLabel, constant: 30)
        NSLayoutConstraint.trailingAnchor(view: closeLabel, superView: view, constant: -8)
        NSLayoutConstraint.topAnchor(view: closeLabel, superView: view, constant: 8)

        abilityNameLabel.translatesAutoresizingMaskIntoConstraints = false
        abilityNameLabel.textAlignment = .center
        NSLayoutConstraint.topAnchor(view: abilityNameLabel, superView: view, constant: 8)
        NSLayoutConstraint.trailingAnchor(view: abilityDetailLabel, superView: closeLabel, constant: -8)
        NSLayoutConstraint.leadingAnchor(view: abilityDetailLabel, superView: view, constant: 8)
        NSLayoutConstraint.heightConstant(view: abilityNameLabel, constant: 30)
        NSLayoutConstraint.centerX(view: abilityNameLabel, superView: view)

        abilityDetailLabel.translatesAutoresizingMaskIntoConstraints = false
        abilityDetailLabel.contentMode = .scaleToFill
        abilityDetailLabel.sizeToFit()
        abilityDetailLabel.numberOfLines = 0
        abilityDetailLabel.textColor = .black
        NSLayoutConstraint.yAxisAnchor(firstViewAnchor: abilityDetailLabel.topAnchor, superViewAnchor: abilityNameLabel.bottomAnchor, constant: 25)
        NSLayoutConstraint.bottomAnchor(view: abilityDetailLabel, superView: view)
        NSLayoutConstraint.trailingAnchor(view: abilityDetailLabel, superView: view, constant: -8)
        NSLayoutConstraint.leadingAnchor(view: abilityDetailLabel, superView: view, constant: 8)
    }

    func configureSubViews() {
        (viewModel as? PokemonAbilityDetailsViewModel)?.pokemonAbilityDetailsDetails.subscribe(onNext: { [weak self] in
            self?.abilityDetailLabel.text = $0.effectEntries?.first(where: { $0.language?.name == "en" })?.effect
            self?.loadingView.stop()
        }).disposed(by: bag)
    }

    @objc
    func handleTap(_: UITapGestureRecognizer) {
        if let navigationController = navigationController {
            navigationController.dismiss(animated: true, completion: nil)
        } else {
            dismiss(animated: true, completion: nil)
        }
    }
}

extension PokemonAbilityDetailsViewController: UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController,
                                presenting: UIViewController?,
                                source _: UIViewController)
        -> UIPresentationController? {
        ModalPresentationController(delegate: self, presentedViewController: presented, presenting: presenting)
    }
}

extension PokemonAbilityDetailsViewController: ModalPresentationControllerDelegate {
    func updateFrameOfPresentedViewInContainerView(frame: CGRect) -> CGRect {
        CGRect(x: 0, y: frame.height / 2, width: frame.width, height: frame.height / 2)
    }
}
