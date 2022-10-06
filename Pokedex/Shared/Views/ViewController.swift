//
//  ViewController.swift
//  Pokedex
//
//  Created by André Luis Barbosa Coutinho on 05/10/22.
//

import UIKit

protocol ViewController where Self: UIViewController {
    var coordinator: Coordinator? { get set }
    var viewModel: ViewModel? { get set }
    func addSubViews()
    func configureSubViews()
    func configureConstraints()
    func handle(error: Error)
}

extension ViewController {
    func addSubViews() {}
    func configureSubViews() {}
    func configureConstraints() {}
    func handle(error _: Error) {}
}
