//  UIImage+Extension.swift
//  Pokedex
//
//  Created by André Luis Barbosa Coutinho on 05/10/22.
//  Source: https://stackoverflow.com/questions/40873685/how-to-cache-images-using-urlsession-in-swift
import UIKit

extension UIImageView {
    static func loadFrom(endPoint: String, urlIsFULL: Bool = false, completion: @escaping (UIImageView?) -> Void) {
        let imageView = UIImageView()

        imageView.image = nil

        let client = HttpClient(baseURL: Urls.frontDefaultPokemonImageURL)

        if urlIsFULL {
            client.getImageFrom(url: endPoint) { result in
                switch result {
                case let .success(image):
                    imageView.image = image
                    completion(imageView)
                default:
                    completion(UIImageView())
                }
            }
            return
        } else {
            client.getImage(url: endPoint) { result in
                switch result {
                case let .success(image):
                    imageView.image = image
                    completion(imageView)
                default:
                    completion(UIImageView())
                }
            }
        }
    }

}
