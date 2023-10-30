//
//  PTCuratedCategoryCollectionViewCell.swift
//  Podtalks
//
//  Created by Ashish Mohite + on 30/10/23.
//

import UIKit

class PTCuratedCategoryCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "PTCuratedCategoryCollectionViewCell"
    
    private let categoryName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        label.font = .systemFont(ofSize: 12, weight: .bold)
        return label
    }()
    private let viewAll: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("View all", for: .normal)
        button.isHidden = true
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .tertiarySystemBackground
        contentView.addSubview(categoryName)
        contentView.addSubview(viewAll)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Not loaded for: PTCuratedCategoryCollectionViewCell")
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            categoryName.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
            categoryName.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 4),
            categoryName.rightAnchor.constraint(equalTo: viewAll.leftAnchor, constant: -4),
            
            viewAll.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
            viewAll.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -4),
            viewAll.leftAnchor.constraint(equalTo: categoryName.rightAnchor, constant: 4),
        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        categoryName.text = nil
        viewAll.isHidden = true
    }
    
    func configure(with curatedCategory: CuratedPodcast) {
        categoryName.text = curatedCategory.title
        viewAll.isHidden = curatedCategory.canloadMore
    }
    
}
