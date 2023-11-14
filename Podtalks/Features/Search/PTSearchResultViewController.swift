//
//  PTSearchResultViewController.swift
//  Podtalks
//
//  Created by Ashish Mohite + on 12/11/23.
//

import UIKit

protocol PTSearchResultViewControllerDelegate: AnyObject {
    func ptSearchResultViewController(_ controller: PTSearchResultViewController, didTap podcast: PTPodcast)
    func ptSearchResultViewController(_ controller: PTSearchResultViewController, didTap episode: PTEpisode)
}

class PTSearchResultViewController: UIViewController {
    
    weak var delegate: PTSearchResultViewControllerDelegate?
    private let resultsView = PTSearchResultsView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(resultsView)
        resultsView.delegate = self
        addConstraints()
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            resultsView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            resultsView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            resultsView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            resultsView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func load(with results: [PTSearchResults]) {
        resultsView.load(with: results)
    }

}

// MARK: - Search results view delegate
extension PTSearchResultViewController: PTSearchResultsViewDelegate {
    
    func ptSearchResultsView(_ searchResultsView: PTSearchResultsView, didSelectItem podcast: PTPodcast) {
        delegate?.ptSearchResultViewController(self, didTap: podcast)
    }
    
    func ptSearchResultsView(_ searchResultsView: PTSearchResultsView, didSelectItem episode: PTEpisode) {
        delegate?.ptSearchResultViewController(self, didTap: episode)
    }
}
