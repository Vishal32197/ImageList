//
//  LazyImageView.swift
//  ImageListDemo
//
//  Created by Bishal Ram on 15/05/24.
//

import UIKit
import Foundation
import Stevia

class LazyImageView: UIImageView {
    
    private let imageCache = NSCache<AnyObject, UIImage>()
    
    func loadImage(_ thumbnailImageURL: URL, _ placeholderImage: URL) {
        
        if let cachedImage = self.imageCache.object(forKey: thumbnailImageURL as AnyObject) {
            self.image = cachedImage
            return
        }

        DispatchQueue.global().async { [weak self] in
            if let imageData = try? Data(contentsOf: thumbnailImageURL) {
                if let image = UIImage(data: imageData) {
                    DispatchQueue.main.async {
                        self?.imageCache.setObject(image, forKey: thumbnailImageURL as AnyObject)
                        self?.image = image
                    }
                }
            }
        }
    }
}
