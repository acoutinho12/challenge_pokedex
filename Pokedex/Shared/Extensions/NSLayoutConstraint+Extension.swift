//
//  NSLayoutConstraint+Extension.swift
//  Pokedex
//
//  Created by André Luis Barbosa Coutinho on 06/10/22.
//

import UIKit

protocol AutoLayoutHelper {
    static func center(view: UIView, superView: UIView)

    static func centerX(view: UIView, superView: UIView)

    static func centerY(view: UIView, superView: UIView)

    static func widthAnchor(view: UIView, superView: UIView)

    static func widthConstant(view: UIView, constant: CGFloat)

    static func heightAnchor(view: UIView, superView: UIView)

    static func heightConstant(view: UIView, constant: CGFloat)

    static func widthHeightConstant(view: UIView, constant: CGFloat)

    static func bottomAnchor(view: UIView, superView: UIView, isSafeArea: Bool, constant: CGFloat)

    static func topAnchor(view: UIView, superView: UIView, isSafeArea: Bool, constant: CGFloat)

    static func leadingAnchor(view: UIView, superView: UIView, constant: CGFloat)

    static func trailingAnchor(view: UIView, superView: UIView, constant: CGFloat)

    static func yAxisAnchor(firstViewAnchor: NSLayoutYAxisAnchor, superViewAnchor: NSLayoutYAxisAnchor)

    static func xAxisAnchor(firstViewAnchor: NSLayoutXAxisAnchor, superViewAnchor: NSLayoutXAxisAnchor)
}

extension NSLayoutConstraint: AutoLayoutHelper {
    static func center(view: UIView, superView: UIView) {
        NSLayoutConstraint.activate([view.centerXAnchor.constraint(equalTo: superView.centerXAnchor),
                                     view.centerYAnchor.constraint(equalTo: superView.centerYAnchor)])
    }

    static func centerX(view: UIView, superView: UIView) {
        NSLayoutConstraint.activate([view.centerXAnchor.constraint(equalTo: superView.centerXAnchor)])
    }

    static func centerY(view: UIView, superView: UIView) {
        NSLayoutConstraint.activate([view.centerYAnchor.constraint(equalTo: superView.centerYAnchor)])
    }

    static func widthAnchor(view: UIView, superView: UIView) {
        NSLayoutConstraint.activate([view.widthAnchor.constraint(equalTo: superView.widthAnchor)])
    }

    static func widthConstant(view: UIView, constant: CGFloat) {
        NSLayoutConstraint.activate([view.widthAnchor.constraint(equalToConstant: constant)])
    }

    static func heightAnchor(view: UIView, superView: UIView) {
        NSLayoutConstraint.activate([view.heightAnchor.constraint(equalTo: superView.heightAnchor)])
    }

    static func heightConstant(view: UIView, constant: CGFloat) {
        NSLayoutConstraint.activate([view.heightAnchor.constraint(equalToConstant: constant)])
    }

    static func widthHeightConstant(view: UIView, constant: CGFloat) {
        heightConstant(view: view, constant: constant)
        widthConstant(view: view, constant: constant)
    }

    static func bottomAnchor(view: UIView, superView: UIView, isSafeArea: Bool = false, constant: CGFloat = 0.0) {
        if isSafeArea {
            NSLayoutConstraint.activate([view.bottomAnchor.constraint(equalTo: superView.safeAreaLayoutGuide.bottomAnchor, constant: constant)])
        } else {
            NSLayoutConstraint.activate([view.bottomAnchor.constraint(equalTo: superView.bottomAnchor, constant: constant)])
        }
    }

    static func topAnchor(view: UIView, superView: UIView, isSafeArea: Bool = false, constant: CGFloat = 0.0) {
        if isSafeArea {
            NSLayoutConstraint.activate([view.bottomAnchor.constraint(equalTo: superView.safeAreaLayoutGuide.topAnchor, constant: constant)])
        } else {
            NSLayoutConstraint.activate([view.bottomAnchor.constraint(equalTo: superView.topAnchor, constant: constant)])
        }
    }

    static func leadingAnchor(view: UIView, superView: UIView, constant: CGFloat = 0.0) {
        NSLayoutConstraint.activate([view.leadingAnchor.constraint(equalTo: superView.leadingAnchor, constant: constant)])
    }

    static func trailingAnchor(view: UIView, superView: UIView, constant: CGFloat = 0.0) {
        NSLayoutConstraint.activate([view.trailingAnchor.constraint(equalTo: superView.trailingAnchor, constant: constant)])
    }

    static func xAxisAnchor(firstViewAnchor: NSLayoutXAxisAnchor, superViewAnchor: NSLayoutXAxisAnchor) {
        NSLayoutConstraint.activate([firstViewAnchor.constraint(equalTo: superViewAnchor)])
    }

    static func yAxisAnchor(firstViewAnchor: NSLayoutYAxisAnchor, superViewAnchor: NSLayoutYAxisAnchor) {
        NSLayoutConstraint.activate([firstViewAnchor.constraint(equalTo: superViewAnchor)])
    }
}
