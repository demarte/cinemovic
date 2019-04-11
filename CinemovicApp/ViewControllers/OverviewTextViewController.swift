//
//  OverviewTextViewController.swift
//  CinemovicApp
//
//  Created by Ivan De Martino on 4/4/19.
//  Copyright © 2019 Ivan De Martino. All rights reserved.
//

import UIKit

final class OverviewTextViewController: UIViewController, UIScrollViewDelegate {

  var overviewText: String?

  @IBOutlet weak var overviewLabel: UILabel!

  @IBOutlet weak var scrollView: UIScrollView! {
    didSet {
      scrollView.delegate = self
    }
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    setUpOverviewTextView()
    setUpScrollView()
  }

  private func setUpOverviewTextView() {
    if let text = overviewText {
      overviewLabel.text = text
    }
  }

  private func setUpScrollView() {
    scrollView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      scrollView.bottomAnchor.constraint(equalTo: overviewLabel.bottomAnchor)
      ])
  }
}
