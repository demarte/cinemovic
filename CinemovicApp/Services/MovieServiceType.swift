//
//  MovieServiceType.swift
//  CinemovicApp
//
//  Created by Ivan De Martino on 3/26/19.
//  Copyright © 2019 Ivan De Martino. All rights reserved.
//

import Foundation

protocol MovieServiceType {
  func movie(for searchTerm: String, page: Int, completion: @escaping ((Result<PagedMovieResult>) -> Void))
}
