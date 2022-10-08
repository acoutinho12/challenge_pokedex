//
//  ViewModel.swift
//  Pokedex
//
//  Created by André Luis Barbosa Coutinho on 05/10/22.
//

import Foundation

protocol ViewModel: AnyObject {
    var coordinator: Coordinator? { get set }
    func viewDidLoad()
}

extension ViewModel {
    func viewDidLoad() {}
}
