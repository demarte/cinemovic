//
//  PagedMovieResult.swift
//  CinemovicApp
//
//  Created by Ivan De Martino on 3/26/19.
//  Copyright © 2019 Ivan De Martino. All rights reserved.
//

import Foundation

struct PagedMovieResult: Codable {

  let totalOfResults: Int
  let totalOfPages: Int
  let movies: [Movie]

  enum CodingKeys: String, CodingKey {
    case totalOfResults = "total_results"
    case totalOfPages = "total_pages"
    case movies = "results"
  }
}
