//
//  DiscoverViewController.swift
//  Podtalks
//
//  Created by Ashish Mohite + on 28/10/23.
//

import UIKit

final class DiscoverViewController: UIViewController, DiscoverViewmodelDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Discover"
        
        let viewmodel = DiscoverViewmodel()
        viewmodel.delegate = self
//        viewmodel.load()
    }
    
    
    func updateUI(for model: DiscoverUI) {
        print(model.genres)
    }
    
    func showError(with message: String?) {
        print(message)
    }

}
