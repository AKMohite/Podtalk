//
//  PTSettings.swift
//  Podtalks
//
//  Created by Ashish Mohite + on 08/11/23.
//

import UIKit

struct PTSettings: Identifiable {
    let id = UUID()

        public let type: PTSettingsOption
        public let onTapHandler: (PTSettingsOption) -> Void

        // MARK: - Init

        init(type: PTSettingsOption, onTapHandler: @escaping (PTSettingsOption) -> Void) {
            self.type = type
            self.onTapHandler = onTapHandler
        }

        // MARK: - Public

        public var image: UIImage? {
            return type.iconImage
        }

        public var title: String {
            return type.displayTitle
        }

        public var iconContainerColor: UIColor {
            return type.iconContainerColor
        }
}
