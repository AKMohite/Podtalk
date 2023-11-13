//
//  PTSearchResultViewController.swift
//  Podtalks
//
//  Created by Ashish Mohite + on 12/11/23.
//

import UIKit

class PTSearchResultViewController: UIViewController {
    
    private let resultsView = PTSearchResultsView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(resultsView)
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
