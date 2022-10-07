//
//  PokemonCarouselView.swift
//  Pokedex
//
//  Created by André Luis Barbosa Coutinho on 07/10/22.
//

import ImageSlideshow
import UIKit

final class PokemonCarouselView: ImageSlideshow {
    init() {
        super.init(frame: CGRect())
        pageIndicator = {
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

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    func configureCarousel(url: String) {
        UIImageView.loadFrom(endPoint: url, urlIsFULL: true) { [weak self] pokemonImageView in
            var images = self?.images
            guard let pokemonImage = pokemonImageView?.image else {
                return
            }
            images?.append(contentsOf: [ImageSource(image: pokemonImage)])
            self?.setImageInputs(images!)
        }
    }
}
