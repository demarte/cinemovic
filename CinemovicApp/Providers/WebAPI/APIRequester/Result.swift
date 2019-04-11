//
//  Result.swift
//  CinemovicApp
//
//  Created by Ivan De Martino on 3/26/19.
//  Copyright © 2019 Ivan De Martino. All rights reserved.
//

import Foundation

enum Result<Value> {
  case success(Value)
  case failure(Error)
}
