//
//  DiscoverViewController.swift
//  Podtalks
//
//  Created by Ashish Mohite + on 28/10/23.
//

import UIKit

final class DiscoverViewController: UIViewController, DiscoverViewmodelDelegate {
    
    private let viewModel = DiscoverViewmodel()
    private let mainView = PTDiscoverMainView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Discover"
        view.addSubview(mainView)
        addConstraints()
        mainView.delegate = self
        viewModel.delegate = self
        viewModel.load()
    }
    
    func updateUI(for model: [DiscoverUISection]) {
        mainView.reloadData(for: model)
    }
    
    func showError(with message: String?) {
        
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mainView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            mainView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            mainView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

}

// MARK: - PTDiscoverMainView delegate
extension DiscoverViewController: PTDiscoverMainViewDelegate {
    func ptDiscoverMainView(_ discoveMainView: PTDiscoverMainView, onTap podcast: PTPodcast) {
        let vc = PodcastDetailViewController(podcast: podcast)
        vc.title = podcast.name
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func ptDiscoverMainView(_ discoveMainView: PTDiscoverMainView, onTap genre: TalkGenre) {
        
    }
}
