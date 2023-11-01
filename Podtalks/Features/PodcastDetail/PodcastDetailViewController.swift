//
//  PodcastDetailViewController.swift
//  Podtalks
//
//  Created by Ashish Mohite + on 01/11/23.
//

import UIKit

class PodcastDetailViewController: UIViewController {
    
    private let podcast: PTPodcast
    
    init(podcast: PTPodcast) {
        self.podcast = podcast
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Not loaded for: PodcastDetailViewController")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
    }
}
