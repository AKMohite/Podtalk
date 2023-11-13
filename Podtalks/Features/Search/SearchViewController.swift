//
//  SearchViewController.swift
//  Podtalks
//
//  Created by Ashish Mohite + on 28/10/23.
//

import UIKit

final class SearchViewController: UIViewController {
    
    private let searchView = PTSearchMainView()
    private let viewModel = SearchViewModel()
    private let searchController: UISearchController = {
        let results = PTSearchResultViewController()
        let vc = UISearchController(searchResultsController: results)
        vc.searchBar.placeholder = "Podcasts, Episodes"
        vc.searchBar.searchBarStyle = .minimal
        vc.definesPresentationContext = true
        return vc
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Search"
        searchController.searchBar.delegate = self
        searchController.searchResultsUpdater = self
        navigationItem.searchController = searchController
        view.addSubview(searchView)
        addConstraints()
        searchView.delegate = self
        viewModel.delegate = self
        viewModel.getAllGenres()
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            searchView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            searchView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            searchView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

// MARK: - Search results updater
extension SearchViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        
    }
    
}

// MARK: - Search viewmodel delegate
extension SearchViewController: SearchViewModelDelegate {
    func load(with genres: [TalkGenre]) {
        searchView.reload(with: genres)
    }
    
    func refresh(with results: [PTSearchResults]) {
        DispatchQueue.main.async {
            guard let resultsController = self.searchController.searchResultsController as? PTSearchResultViewController else {
                return
            }
            resultsController.load(with: results)
        }
    }
    
    func showError(with message: String?) {
        print(message!)
    }
    
    
}

// MARK: - Search view delegate
extension SearchViewController: PTSearchMainViewDelegate {
    
    func ptSearchMainView(_ searchView: PTSearchMainView, didSelectItem genre: TalkGenre) {
        
    }
    
}

// MARK: - Search bar delegate
extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let query = searchBar.text, !query.trimmingCharacters(in: .whitespaces).isEmpty else {
            return
        }
        viewModel.search(with: query)
    }
}
