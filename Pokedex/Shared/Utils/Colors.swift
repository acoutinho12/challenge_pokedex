//
//  Colors.swift
//  Pokedex
//
//  Created by André Luis Barbosa Coutinho on 06/10/22.
//

import UIKit

enum ColorsType: String, CaseIterable {
    case normal
    case fighting
    case flying
    case poison
    case ground
    case rock
    case bug
    case ghost
    case steel
    case fire
    case water
    case grass
    case electric
    case psychic
    case ice
    case dragon
    case dark
    case fairy
    case unknown
    case shadow
}

enum Colors {
    static let primaryColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
    static let secondaryColor = UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1)
    static let primaryBackgroundColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1)
    static let secondaryBackgroundColor = UIColor(red: 0.96, green: 0.96, blue: 0.96, alpha: 1)
    static func getColorBy(type: ColorsType) -> UIColor {
        switch type {
        case .normal:
            return UIColor(rgb: 0xA8A878)
        case .fire:
            return UIColor(rgb: 0xF08030)
        case .water:
            return UIColor(rgb: 0x6890F0)
        case .electric:
            return UIColor(rgb: 0xF8D030)
        case .grass:
            return UIColor(rgb: 0x78C850)
        case .ice:
            return UIColor(rgb: 0x98D8D8)
        case .fighting:
            return UIColor(rgb: 0xC03028)
        case .poison:
            return UIColor(rgb: 0xA040A0)
        case .ground:
            return UIColor(rgb: 0xE0C068)
        case .flying:
            return UIColor(rgb: 0xA890F0)
        case .psychic:
            return UIColor(rgb: 0xF85888)
        case .bug:
            return UIColor(rgb: 0xA8B820)
        case .rock:
            return UIColor(rgb: 0xB8A038)
        case .ghost:
            return UIColor(rgb: 0x705898)
        case .dragon:
            return UIColor(rgb: 0x7038F8)
        case .dark:
            return UIColor(rgb: 0x705848)
        case .steel:
            return UIColor(rgb: 0xB8B8D0)
        case .fairy:
            return UIColor(rgb: 0xEE99AC)
        case .unknown:
            return UIColor(rgb: 0xFFFAAA)
        case .shadow:
            return UIColor(rgb: 0xFFFAAA)
        default:
            return UIColor.white
        }
    }
}
