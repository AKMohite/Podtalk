//
//  ViewController.swift
//  Podtalks
//
//  Created by Ashish Mohite + on 22/10/23.
//

import UIKit

class PodtalkTabViewController: UITabBarController, DiscoverViewmodelDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .cyan
        
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

