//
//  Movie.swift
//  CinemovicApp
//
//  Created by Ivan De Martino on 3/26/19.
//  Copyright © 2019 Ivan De Martino. All rights reserved.
//

import Foundation

struct Movie: Codable {
  let title: String?
  let posterURL: String?
  let voteAverage: Double?
  let overview: String
  let releaseDate: String?
  let voteCount: Int?
  let popularity: Double?
  let originalLanguage: String?
  let originalTitle: String?
  let genreIds: [Int]?

  enum CodingKeys: String, CodingKey {
    case title, overview, popularity
    case posterURL = "poster_path"
    case voteAverage = "vote_average"
    case releaseDate = "release_date"
    case originalTitle = "original_title"
    case originalLanguage = "original_language"
    case voteCount = "vote_count"
    case genreIds = "genre_ids"
  }
}
