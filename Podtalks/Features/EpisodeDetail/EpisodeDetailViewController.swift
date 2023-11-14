//
//  EpisodeDetailViewController.swift
//  Podtalks
//
//  Created by Ashish Mohite + on 14/11/23.
//

import UIKit

class EpisodeDetailViewController: UIViewController {

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
        view.backgroundColor = .systemIndigo
        viewModel.delegate = self
        viewModel.fetchDetails(with: episode)
    }

}

// MARK: - View model delegate
extension EpisodeDetailViewController: EpisodeDetailViewmodelDelegate {
    
    func loadData(with details: PTEpisode) {
        DispatchQueue.main.async {
            print(details)
        }
    }
    
    func showError(with message: String?) {
        
    }
    
}
