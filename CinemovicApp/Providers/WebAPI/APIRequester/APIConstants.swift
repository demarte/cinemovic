//
//  APIConstants.swift
//  CinemovicApp
//
//  Created by Ivan De Martino on 3/26/19.
//  Copyright © 2019 Ivan De Martino. All rights reserved.
//

import Foundation

struct APIConstants {
  static let baseURL = URL(string: "https://api.themoviedb.org")!
  static let path = "search"
  static let apiVersion = "3"
  static let apiKey = "f8b77bd2caeee2f4eec797c13accb96e"
  static let imagePath = "t/p"
  static let imageSizeSmall = "w200"
  static let imageSizeLarge = "original"
  static let posterURL = URL(string: "https://image.tmdb.org")!
}
