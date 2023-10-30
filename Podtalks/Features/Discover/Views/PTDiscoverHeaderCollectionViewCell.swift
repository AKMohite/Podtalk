//
//  PTDiscoverHeaderCollectionViewCell.swift
//  Podtalks
//
//  Created by Ashish Mohite + on 30/10/23.
//

import UIKit

class PTDiscoverHeaderCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "PTDiscoverHeaderCollectionViewCell"
    
    private let podcastImg: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.masksToBounds = true
        image.layer.cornerRadius = 4
        image.contentMode = .scaleAspectFill
        image.image = UIImage(systemName: "photo")
        image.clipsToBounds = true
        return image
    }()
    private let podcastName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        label.font = .systemFont(ofSize: 18, weight: .bold)
        return label
    }()
    private let publishedBy: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 16, weight: .light)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .tertiarySystemBackground
        contentView.addSubview(podcastImg)
        contentView.addSubview(podcastName)
        contentView.addSubview(publishedBy)
        addConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            podcastImg.widthAnchor.constraint(equalToConstant: 100),
            podcastImg.topAnchor.constraint(equalTo: contentView.topAnchor),
            podcastImg.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            podcastImg.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 8),
            
//            podcastName.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            podcastName.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            podcastName.leftAnchor.constraint(equalTo: podcastImg.rightAnchor, constant: 8),
            podcastName.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -8),
            
            publishedBy.topAnchor.constraint(equalTo: podcastName.bottomAnchor, constant: 4),
            publishedBy.leftAnchor.constraint(equalTo: podcastImg.rightAnchor, constant: 8),
            publishedBy.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -8),
//            publishedBy.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 8)
        ])
    }
    
    func configure(with podcast: PTPodcast) {
        podcastName.text = podcast.name
        publishedBy.text = podcast.publishedBy ?? "NA"
    }
    
}
