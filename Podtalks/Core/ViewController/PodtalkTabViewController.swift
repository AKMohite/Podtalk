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
        
        discoverVC.navigationItem.largeTitleDisplayMode = .automatic
        searchVC.navigationItem.largeTitleDisplayMode = .automatic
        libraryVC.navigationItem.largeTitleDisplayMode = .automatic
        settingsVC.navigationItem.largeTitleDisplayMode = .automatic
        
        let discoverNav = UINavigationController(rootViewController: discoverVC)
        let searchNav = UINavigationController(rootViewController: searchVC)
        let libraryNav = UINavigationController(rootViewController: libraryVC)
        let settingsNav = UINavigationController(rootViewController: settingsVC)
        
        discoverNav.tabBarItem = UITabBarItem(title: "Discover", image: UIImage(systemName: "rectangle.3.offgrid"), tag: 1)
        searchNav.tabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass"), tag: 2)
        libraryNav.tabBarItem = UITabBarItem(title: "Library", image: UIImage(systemName: "folder"), tag: 3) // music.note.list
        settingsNav.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(systemName: "gear"), tag: 4)
        
        let rootControllers = [discoverNav, searchNav, libraryNav, settingsNav]
        
        for controller in rootControllers {
            controller.navigationBar.prefersLargeTitles = true
        }
        
        setViewControllers(
            rootControllers,
            animated: true
        )
    }
    
}
