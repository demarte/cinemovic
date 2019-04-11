//
//  MovieService.swift
//  CinemovicApp
//
//  Created by Ivan De Martino on 3/26/19.
//  Copyright © 2019 Ivan De Martino. All rights reserved.
//

import Foundation

struct MovieService: MovieServiceType {

  let movieProvider: MovieProviderType

  init(movieProvider: MovieProviderType = MovieProvider()) {
    self.movieProvider = movieProvider
  }

  func movie(for searchTerm: String, page: Int, completion: @escaping ((Result<PagedMovieResult>) -> Void)) {
    movieProvider.movie(for: searchTerm, page: page, completion: completion)
  }
}
