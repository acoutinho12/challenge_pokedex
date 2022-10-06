//
//  UseCase.swift
//  Pokedex
//
//  Created by André Luis Barbosa Coutinho on 05/10/22.
//

import Foundation

protocol UseCase {
    associatedtype Params
    associatedtype ReturnType
    func execute(params: Params, completion: @escaping (ReturnType) -> Void)
}
