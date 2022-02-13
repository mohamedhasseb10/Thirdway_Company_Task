//
//  ImageView+downloadimage.swift
//  ThirdwayTask
//
//  Created by Mohamed Hasseb on 28/01/2022.
//

import Foundation
import UIKit

extension UIImageView {
    func download(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
        contentMode = mode
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
            else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }
        DispatchQueue.global().async {
            task.resume()
        }
    }
}
