//  UIImage+Extension.swift
//  Pokedex
//
//  Created by André Luis Barbosa Coutinho on 05/10/22.
//  Source: https://stackoverflow.com/questions/40873685/how-to-cache-images-using-urlsession-in-swift
import UIKit

extension UIImageView {
    static func loadFrom(endPoint: String, completion: @escaping (UIImageView?) -> Void) {
        let activityIndicator = UIActivityIndicatorView()
        let imageView = UIImageView()

        // setup activityIndicator...
        activityIndicator.color = .systemGray

        imageView.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.centerXAnchor.constraint(equalTo: imageView.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: imageView.centerYAnchor).isActive = true
        completion(imageView)

        imageView.image = nil
        activityIndicator.startAnimating()

        let client = HttpClient(baseURL: Urls.frontDefaultPokemonImageURL)

        client.getImage(url: endPoint) { result in
            switch result {
            case let .success(image):
                activityIndicator.stopAnimating()
                imageView.image = image
                completion(imageView)
            default:
                completion(UIImageView())
            }
        }
    }
}
