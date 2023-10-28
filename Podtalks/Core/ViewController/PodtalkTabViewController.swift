//
//  ViewController.swift
//  Podtalks
//
//  Created by Ashish Mohite + on 22/10/23.
//

import UIKit

final class PodtalkTabViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabs()
    }
    
    private func setupTabs() {
        let discoverVC = DiscoverViewController()
        let searchVC = SearchViewController()
        let libraryVC = LibraryViewController()
        let settingsVC = SettingsViewController()
        
        let discoverNav = UINavigationController(rootViewController: discoverVC)
        let searchNav = UINavigationController(rootViewController: searchVC)
        let libraryNav = UINavigationController(rootViewController: libraryVC)
        let settingsNav = UINavigationController(rootViewController: settingsVC)
        
        setViewControllers(
            [discoverNav, searchNav, libraryNav, settingsNav],
            animated: true
        )
    }
    
}
