//
//  MovieEndpoint.swift
//  CinemovicApp
//
//  Created by Ivan De Martino on 3/26/19.
//  Copyright © 2019 Ivan De Martino. All rights reserved.
//

import Foundation

enum MovieEndpoint {
  case movieBySearchTerm(searchTerm: String, page: Int)
}

extension MovieEndpoint: EndpointType {
  var path: String {
    return "movie"
  }

  var method: Method {
    return .get
  }

  var parameters: [String: String]? {
    var parameters: [String: String] = ["api_key": APIConstants.apiKey]
    switch self {
    case .movieBySearchTerm(let searchTerm, let page):
      parameters["query"] = searchTerm
      parameters["page"] = "\(page)"
    }
    return parameters
  }
}
