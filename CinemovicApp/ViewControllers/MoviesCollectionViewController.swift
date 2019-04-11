//
//  MoviesCollectionViewController.swift
//  CinemovicApp
//
//  Created by Ivan De Martino on 3/25/19.
//  Copyright © 2019 Ivan De Martino. All rights reserved.
//

import UIKit

final class MoviesCollectionViewController: UIViewController {

  // MARK: IBOutlets

  @IBOutlet weak var movieCountLabel: UILabel!

  @IBOutlet weak var collectionView: UICollectionView! {
    didSet {
      collectionView.delegate = self
      collectionView.dataSource = self
    }
  }

  // MARK: - Properties
  private let reuseIdentifier = "MovieCell"
  var movies: [Movie] = []
  let movieService: MovieServiceType = MovieService()
  let searchController = UISearchController(searchResultsController: nil)
  let debouncer = Debouncer(timeInterval: 0.7)

  // MARK: - View Setup

  override func viewDidLoad() {
    createSearchBar()
  }

  // MARK: - SearchBar methods

  private func createSearchBar() {
    searchController.searchResultsUpdater = self
    searchController.obscuresBackgroundDuringPresentation = false
    searchController.searchBar.placeholder = "Search for movies..."
    navigationItem.searchController = searchController
    navigationItem.hidesSearchBarWhenScrolling = false
    definesPresentationContext = true
  }

  private func searchBarIsEmpty() -> Bool {
    return searchController.searchBar.text?.isEmpty ?? true
  }

  private func fetchContentForSearchTerm(_ searchTerm: String, page: Int = 1) {
    movieService.movie(for: searchTerm, page: page) { result in
      switch result {
      case .success(let result):
        self.movies = result.movies
        self.removeMovieNullContent()
        DispatchQueue.main.async { [weak self] in
          self?.collectionView.reloadData()
          self?.updateMovieCountLabel()
        }
      case .failure(let error):
        DispatchQueue.main.async {
          let alert = UIAlertController(
            title: "Movie not found",
            message: error.localizedDescription,
            preferredStyle: .alert
          )
          self.present(alert, animated: true, completion: nil)
          self.movieCountLabel.text?.removeAll()
          self.movies.removeAll()
          self.collectionView.reloadData()
        }
      }
    }
  }

  private func removeMovieNullContent() {
    movies = movies.filter { (movie) -> Bool in
      return !(movie.posterURL == nil)
    }
  }

  // MARK: - movieCountLabel methods

  private func updateMovieCountLabel() {
    movieCountLabel.text = movies.count > 1 ? "\(movies.count) movies found" : "1 movie found"
  }

  // MARK: - Segue

  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "ShowDetail" {
      if let movieDetailsViewController = segue.destination as? MovieDetailsViewController,
        let cell = sender as? MovieCollectionViewCell {
        let movie = movies[cell.tag]
        movieDetailsViewController.selectedMovie = movie
      }
    }
  }
}

extension MoviesCollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout, UISearchResultsUpdating {

  // MARK: - CollectionView Delegate and Data Source

  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return movies.count
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(
      withReuseIdentifier: reuseIdentifier,
      for: indexPath
    )
    if let movieCell = cell as? MovieCollectionViewCell {
      if let image = movies[indexPath.item].posterURL {
        movieCell.image.loadImageFromURL(image)
        movieCell.tag = indexPath.row
      }
    }
    return cell
  }

  // MARK: - SearchResultUpdating

  func updateSearchResults(for searchController: UISearchController) {
    if let text = searchController.searchBar.text {
      let textWithoutWhitespaces = text.trimmingCharacters(in: .whitespacesAndNewlines)
      if !textWithoutWhitespaces.isEmpty {
        debouncer.handler = {
          self.fetchContentForSearchTerm(textWithoutWhitespaces)
        }
        debouncer.debounce()
        fetchContentForSearchTerm(textWithoutWhitespaces)
      }
    }
  }
}
