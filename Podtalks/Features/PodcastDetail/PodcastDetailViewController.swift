//
//  PodcastDetailViewController.swift
//  Podtalks
//
//  Created by Ashish Mohite + on 01/11/23.
//

import UIKit

class PodcastDetailViewController: UIViewController {
    
    private let podcast: PTPodcast
    private let detailView: PodcastDetailView = PodcastDetailView()
    private let viewModel = PodcastDetailViewModel()
    
    init(podcast: PTPodcast) {
        self.podcast = podcast
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Not loaded for: PodcastDetailViewController")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(detailView)
        addConstraints()
        viewModel.delegate = self
        viewModel.fetchDetails(with: podcast)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            detailView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            detailView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            detailView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            detailView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

// MARK: - Viewmodel delegate
extension PodcastDetailViewController: PodcastDetailViewModelDelegate {
    func updateUI(with detail: PTPodcastDetails) {
        detailView.load(with: detail)
    }
    
    func showError(with message: String?) {
        
    }
}
