//
//  PTGenreCollectionViewCell.swift
//  Podtalks
//
//  Created by Ashish Mohite + on 31/10/23.
//

import UIKit

class PTGenreCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "PTGenreCollectionViewCell"
    
    private let label: UILabel = {
        let text = UILabel()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.font = .systemFont(ofSize: 18, weight: .semibold)
        text.numberOfLines = 1
        return text
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .tertiarySystemBackground
        layer.masksToBounds = true
        layer.cornerRadius = 6
        addSubview(label)
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Not loaded for: PTGenreCollectionViewCell")
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: topAnchor, constant: 2),
            label.leftAnchor.constraint(equalTo: leftAnchor, constant: 8),
            label.rightAnchor.constraint(equalTo: rightAnchor, constant: -8),
            label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -2),
        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        label.text = nil
    }
    
    func configure(with genre: TalkGenre) {
        label.text = genre.name
    }
    
}
