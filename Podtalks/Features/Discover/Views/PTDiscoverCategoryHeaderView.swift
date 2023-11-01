//
//  PTDiscoverCategoryHeaderView.swift
//  Podtalks
//
//  Created by Ashish Mohite + on 01/11/23.
//

import UIKit

class PTDiscoverCategoryHeaderView: UICollectionReusableView {
    
    static let identifier = "PTDiscoverCategoryHeaderView"
    
    private let category: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(category)
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Cannot initialise for: PTDiscoverCategoryHeaderView")
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            category.topAnchor.constraint(equalTo: topAnchor, constant: 2),
            category.leftAnchor.constraint(equalTo: leftAnchor, constant: 8),
            category.rightAnchor.constraint(equalTo: rightAnchor, constant: -8),
            category.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -2)
        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        category.text = nil
    }
    
    func configure(with categoryName: String) {
        category.text = categoryName
    }
        
}
