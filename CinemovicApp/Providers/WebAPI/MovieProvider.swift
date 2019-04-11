//
//  MovieProvider.swift
//  CinemovicApp
//
//  Created by Ivan De Martino on 3/26/19.
//  Copyright © 2019 Ivan De Martino. All rights reserved.
//

import Foundation

struct MovieProvider: MovieProviderType {

  let apiRequester = APIRequester<MovieEndpoint>()

  func movie(for searchTerm: String, page: Int, completion: @escaping ((Result<PagedMovieResult>) -> Void)) {
    apiRequester.request(
      MovieEndpoint.movieBySearchTerm(searchTerm: searchTerm, page: page),
      completion: completion
    )
  }
}
