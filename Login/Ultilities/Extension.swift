//
//  Extension.swift
//  Login
//
//  Created by Hanh Vo on 6/13/23.
//

import Foundation
import UIKit

let cachedImages = NSCache<NSURL, UIImage>()

extension UIImageView {
    func loadImage(from url: URL){
        if let cachedImage = cachedImages.object(forKey: url as NSURL) {
            self.updateImage(image: cachedImage)
            return
        }
        URLSession.shared.dataTask(with: url){ [weak self] (data, response, error) in
            if let error = error {
                print("Failed fetching image:", error)
                self?.updateImage(image: UIImage(named: "placeholder"))
                return
            }
            guard let data = data, let image = UIImage(data: data) else {
                self?.updateImage(image: UIImage(named: "placeholder"))
                return
            }
            cachedImages.setObject(image, forKey: url as NSURL)
            self?.updateImage(image: image)
        }.resume()
    }

    private func updateImage(image: UIImage?) {
        DispatchQueue.main.async {
            self.image = image
        }
    }
}

extension UIViewController {
    func presentAlert(message: String){
        let alertController = UIAlertController(title: "OK", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Try again", style: .cancel)
        alertController.addAction(action)
        DispatchQueue.main.async {
            self.present(alertController, animated: true)
        }
    }
}
