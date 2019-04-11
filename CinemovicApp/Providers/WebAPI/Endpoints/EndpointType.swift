//
//  EndpointType.swift
//  CinemovicApp
//
//  Created by Ivan De Martino on 3/26/19.
//  Copyright © 2019 Ivan De Martino. All rights reserved.
//

import Foundation

protocol EndpointType {
  var request: URLRequest? { get }
  var baseURL: URL { get }
  var path: String { get }
  var method: Method { get }
  var headers: [String: String]? { get }
  var parameters: [String: String]? { get }
}

extension EndpointType {
  var headers: [String: String]? {
    return ["Content-Type": "application/json;charset=utf-8"]
  }

  var baseURL: URL {
    return APIConstants.baseURL
      .appendingPathComponent(APIConstants.apiVersion)
      .appendingPathComponent(APIConstants.path)
  }

  var request: URLRequest? {
    return nil
  }
}
