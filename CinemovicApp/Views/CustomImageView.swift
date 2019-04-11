//
//  CustomImageView.swift
//  CinemovicApp
//
//  Created by Ivan De Martino on 3/27/19.
//  Copyright © 2019 Ivan De Martino. All rights reserved.
//

import UIKit

let imageCache = NSCache<NSString, UIImage>()

class CustomImageView: UIImageView {

  var imageURLString: String?

  func loadImageFromURL(_ imagePath: String, imageSize: String = APIConstants.imageSizeSmall) {
    imageURLString = imagePath

    let url = buildImageURL(with: imagePath, imageSize: imageSize)
    image = nil

    if let imageFromCache = imageCache.object(forKey: imagePath as NSString) {
      self.image = imageFromCache
      return
    }

    DispatchQueue.global(qos: .default).async {
      do {
        if let urlContents = try? Data(contentsOf: url) {
          if let image = UIImage(data: urlContents) {
            DispatchQueue.main.async {

              if self.imageURLString == imagePath {
                self.image = image
                imageCache.setObject(image, forKey: imagePath as NSString)
              }
            }
          }
        }
      }
    }
  }

  private func buildImageURL(with imagePath: String, imageSize: String) -> URL {
    var url = APIConstants.posterURL
    url.appendPathComponent(APIConstants.imagePath)
    url.appendPathComponent(imageSize)
    url.appendPathComponent(imagePath)
    return url
  }
}
