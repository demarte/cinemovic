//
//  MovieDetailsViewController.swift
//  CinemovicApp
//
//  Created by Ivan De Martino on 3/27/19.
//  Copyright © 2019 Ivan De Martino. All rights reserved.
//

import UIKit

class MovieDetailsViewController: UIViewController {

  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var image: CustomImageView!
  @IBOutlet weak var releaseDateLabel: UILabel!
  @IBOutlet weak var voteAverageLabel: UILabel!
  @IBOutlet weak var overviewLabel: UILabel!
  @IBOutlet weak var originalTitleLabel: UILabel!
  @IBOutlet weak var originalLanguageLabel: UILabel!
  @IBOutlet weak var popularityLabel: UILabel!
  @IBOutlet weak var voteCountLabel: UILabel!
  @IBOutlet weak var genreLabel: UILabel!

  var selectedMovie: Movie?

  override func viewDidLoad() {
    super.viewDidLoad()
    setUpMovieViews()
  }

  private func setUpMovieViews() {
    if let movie = selectedMovie {
      titleLabel.text = movie.title
      image.loadImageFromURL(movie.posterURL ?? "")
      releaseDateLabel.text = movie.releaseDate?.removeBefore(character: "-")
      genreLabel.text = fetchGenresBy(genreIds: movie.genreIds ?? []).joined(separator: ", ")
      voteAverageLabel.text = "\(movie.voteAverage ?? 0.0)"
      overviewLabel.text = movie.overview
      originalTitleLabel.text = movie.originalTitle
      originalLanguageLabel.text = movie.originalLanguage
      popularityLabel.text = "\(movie.popularity ?? 0)"
      voteCountLabel.text = "\(movie.voteCount ?? 0)"

      image.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(showPoster(_:))))
      overviewLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(showOverview(_:))))
    }
  }

  private func fetchGenresBy(genreIds: [Int]) -> [String] {
    let genres = Genre.genres()
    var fetchedGenres: [String] = []
    genreIds.forEach { genreId in
      if let genre = genres[genreId] {
        fetchedGenres.append(genre)
      }
    }
    return fetchedGenres
  }

  @objc private func showPoster(_ recognizer: UIGestureRecognizer) {
    switch recognizer.state {
    case .ended:
      if let posterController = storyboard?.instantiateViewController(withIdentifier: "PosterViewController")
        as? PosterViewController, let movie = selectedMovie {
        posterController.posterPath = movie.posterURL
        navigationController?.pushViewController(posterController, animated: true)
      }
    default: break
    }
  }

  @objc private func showOverview(_ recognizer: UIGestureRecognizer) {
    switch recognizer.state {
    case .ended:
      if let overviewController = storyboard?.instantiateViewController(withIdentifier: "OverviewViewController")
        as? OverviewTextViewController, let movie = selectedMovie {
        overviewController.overviewText = movie.overview
        navigationController?.pushViewController(overviewController, animated: true)
      }
    default: break
    }
  }
}

extension String {
  func removeBefore(character: Character) -> String {
    guard let firstString = self.split(separator: character).first else { return self }
    return String(firstString)
  }
}
