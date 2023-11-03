//
//  PodcastDetailInfoReusableView.swift
//  Podtalks
//
//  Created by Ashish Mohite + on 03/11/23.
//

import UIKit

class PodcastDetailInfoReusableView: UICollectionReusableView {
    
    static let identifier = "PodcastDetailInfoReusableView"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Cannot load for: PodcastDetailInfoReusableView")
    }
    
    private func addConstraints() {
        
    }
        
}
