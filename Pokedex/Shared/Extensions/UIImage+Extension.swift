//  UIImage+Extension.swift
//  Pokedex
//
//  Created by André Luis Barbosa Coutinho on 05/10/22.
//  Source: https://stackoverflow.com/questions/40873685/how-to-cache-images-using-urlsession-in-swift
import UIKit

extension UIImageView {
    static func loadFrom(urlString: String, completion: @escaping (UIImageView?) -> Void) {
        guard let url = URL(string: urlString) else { return }
        let activityIndicator = UIActivityIndicatorView()
        let imageView = UIImageView()

        // setup activityIndicator...
        activityIndicator.color = .systemGray

        imageView.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.centerXAnchor.constraint(equalTo: imageView.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: imageView.centerYAnchor).isActive = true
        completion(imageView)
        let imageURL = url

        imageView.image = nil
        activityIndicator.startAnimating()

        URLSession.shared.dataTask(with: url, completionHandler: { data, _, error in
            if error != nil {
                DispatchQueue.main.async {
                    activityIndicator.stopAnimating()
                }
                return
            }

            DispatchQueue.main.async {
                if let data = data, let image = UIImage(data: data) {
                    if imageURL == url {
                        imageView.image = image
                    }
                }
                activityIndicator.stopAnimating()
                completion(imageView)
            }
        }).resume()
    }
}
