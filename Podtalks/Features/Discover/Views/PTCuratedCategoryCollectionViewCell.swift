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
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 2
        label.textAlignment = .left
        label.clipsToBounds = true
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        return label
    }()
//    private let viewAll: UIButton = {
//        let button = UIButton()
//        button.translatesAutoresizingMaskIntoConstraints = false
//        button.setTitle("View all", for: .normal)
//        button.isHidden = true
//        button.backgroundColor = .purple
//        return button
//    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .secondarySystemBackground
        layer.cornerRadius = 8
        layer.masksToBounds = true
        contentView.addSubview(categoryName)
//        contentView.addSubview(viewAll)
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Not loaded for: PTCuratedCategoryCollectionViewCell")
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            categoryName.topAnchor.constraint(equalTo: topAnchor, constant: 4),
            categoryName.leftAnchor.constraint(equalTo: leftAnchor, constant: 6),
            categoryName.rightAnchor.constraint(equalTo: rightAnchor, constant: -6),
//            categoryName.rightAnchor.constraint(equalTo: viewAll.leftAnchor, constant: -2),

//            viewAll.topAnchor.constraint(equalTo: topAnchor, constant: 4),
//            viewAll.rightAnchor.constraint(equalTo: rightAnchor, constant: -6)
        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        categoryName.text = nil
//        viewAll.isHidden = true
    }
    
    func configure(with curatedCategory: CuratedPodcast) {
        categoryName.text = curatedCategory.title
//        viewAll.isHidden = !curatedCategory.canloadMore
    }
    
}
