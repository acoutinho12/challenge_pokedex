//
//  ModalPresentationController.swift
//  Pokedex
//
//  Created by André Luis Barbosa Coutinho on 08/10/22.
//

import UIKit

protocol ModalPresentationControllerDelegate: AnyObject {
    func updateFrameOfPresentedViewInContainerView(frame: CGRect) -> CGRect
}

class ModalPresentationController: UIPresentationController {
    private weak var modalPresentationDelegate: ModalPresentationControllerDelegate!

    convenience init(delegate: ModalPresentationControllerDelegate,
                     presentedViewController: UIViewController,
                     presenting presentingViewController: UIViewController?) {
        self.init(presentedViewController: presentedViewController,
                  presenting: presentingViewController)
        modalPresentationDelegate = delegate
    }

    override var frameOfPresentedViewInContainerView: CGRect {
        modalPresentationDelegate.updateFrameOfPresentedViewInContainerView(frame: super.frameOfPresentedViewInContainerView)
    }
}
