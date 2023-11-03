//
//  PodcastDetailView.swift
//  Podtalks
//
//  Created by Ashish Mohite + on 03/11/23.
//

import UIKit

class PodcastDetailView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .red
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Cannot load for: PodcastDetailView")
    }
    
    private func addConstraints() {
        
    }

}
