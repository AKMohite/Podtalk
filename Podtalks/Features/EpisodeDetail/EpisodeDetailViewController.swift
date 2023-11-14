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
        viewModel.fetchDetails(with: episode)
    }

}
