//
//  PTSettingsOption.swift
//  Podtalks
//
//  Created by Ashish Mohite + on 08/11/23.
//

import UIKit

enum PTSettingsOption: CaseIterable {
case rateApp
case contactUs
case terms
case privacy
case apiReference
case viewCode
    
    var targetUrl: URL? {
        switch self {
        case .rateApp:
            return nil
        case .contactUs:
            return URL(string: "https://github.com/AKMohite")
        case .terms:
            return URL(string: "https://github.com/AKMohite/AKMohite/blob/master/README.md")
        case .privacy:
            return URL(string: "https://github.com/AKMohite/AKMohite/blob/master/README.md")
        case .apiReference:
            return URL(string: "https://www.listennotes.com/api/docs/#get-api-v2-search")
        case .viewCode:
            return URL(string: "https://github.com/AKMohite/Podtalk-iOS")
        }
    }
    
    var displayTitle: String {
        switch self {
        case .rateApp:
            return "Rate App"
        case .contactUs:
            return "Contact Us"
        case .terms:
            return "Terms of Service"
        case .privacy:
            return "Privacy Policy"
        case .apiReference:
            return "API Reference"
        case .viewCode:
            return "View App Code"
        }
    }
    
    var iconContainerColor: UIColor {
        switch self {
        case .rateApp:
            return .systemBlue
        case .contactUs:
            return .systemGreen
        case .terms:
            return .systemRed
        case .privacy:
            return .systemYellow
        case .apiReference:
            return .systemOrange
        case .viewCode:
            return .systemPink
        }
    }
    
    var iconImage: UIImage? {
        switch self {
        case .rateApp:
            return UIImage(systemName: "star.fill")
        case .contactUs:
            return UIImage(systemName: "paperplane")
        case .terms:
            return UIImage(systemName: "doc")
        case .privacy:
            return UIImage(systemName: "lock")
        case .apiReference:
            return UIImage(systemName: "list.clipboard")
        case .viewCode:
            return UIImage(systemName: "hammer.fill")
        }
    }
}
