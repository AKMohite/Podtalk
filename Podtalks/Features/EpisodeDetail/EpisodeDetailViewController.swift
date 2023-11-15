//
//  EpisodeDetailViewController.swift
//  Podtalks
//
//  Created by Ashish Mohite + on 14/11/23.
//

import UIKit

class EpisodeDetailViewController: UIViewController {

    private let detailsView = PTEpisodeDetailView()
    private let viewModel = EpisodeDetailViewmodel()
    private let episode: PTEpisode
    
    init(episode: PTEpisode) {
        self.episode = episode
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Not loaded for: EpisodeDetailViewController")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        detailsView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(detailsView)
        addConstraints()
        detailsView.delegate = self
        viewModel.delegate = self
        viewModel.fetchDetails(with: episode)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            detailsView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            detailsView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            detailsView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            detailsView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

}

// MARK: - View model delegate
extension EpisodeDetailViewController: EpisodeDetailViewmodelDelegate {
    
    func loadData(with details: PTEpisodeDetail) {
        DispatchQueue.main.async {
            self.detailsView.configure(with: details)
        }
    }
    
    func showError(with message: String?) {
        
    }
    
}

// MARK: - Detail view delegate
extension EpisodeDetailViewController: PTEpisodeDetailViewDelegate {
    func ptEpisodeDetailView(_ detailView: PTEpisodeDetailView, didTap podcast: PTPodcast) {
        let vc = PodcastDetailViewController(podcast: podcast)
        vc.title = podcast.name
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
}
