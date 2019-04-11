//
//  PosterViewController.swift
//  CinemovicApp
//
//  Created by Ivan De Martino on 4/4/19.
//  Copyright © 2019 Ivan De Martino. All rights reserved.
//

import UIKit

final class PosterViewController: UIViewController {

  var posterPath: String?

  @IBOutlet weak var customImageView: CustomImageView!

  override func viewDidLoad() {
    super.viewDidLoad()
    setUpCustomImageView()
  }

  func setUpCustomImageView() {
    if let path = posterPath {
      customImageView.loadImageFromURL(path, imageSize: APIConstants.imageSizeLarge)
    }
  }
}
