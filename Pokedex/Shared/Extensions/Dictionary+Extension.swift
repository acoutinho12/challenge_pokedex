//
//  Dictionary+Extension.swift
//  Pokedex
//
//  Created by André Luis Barbosa Coutinho on 06/10/22.
//  Source: https://www.appsloveworld.com/swift/100/307/swift-replace-key-value-in-array-of-dictionaries-with-nested-dictionaries

import Foundation

extension Dictionary {
    func iterateThroughAllKeyValues(execute execution: ((Key, Value)) -> Void) {
        for element in self {
            if let dictionary = element.value as? [Key: Value] {
                dictionary.iterateThroughAllKeyValues(execute: execution)
            } else {
                execution(element)
            }
        }
    }
}
