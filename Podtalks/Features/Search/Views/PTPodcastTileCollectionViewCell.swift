//
//  PTPodcastTileCollectionViewCell.swift
//  Podtalks
//
//  Created by Ashish Mohite + on 13/11/23.
//

import UIKit

class PTPodcastTileCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "PTPodcastTileCollectionViewCell"
    private var loader: PTImageLoader?
    private var imageTaskId: UUID?
    private let imageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 8
        iv.layer.masksToBounds = true
        return iv
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(imageView)
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Could load init for: PTPodcastTileView")
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 160),
            imageView.heightAnchor.constraint(equalToConstant: 160),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            imageView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        if let id = imageTaskId {
            loader?.cancelLoad(id)
        }
        imageTaskId = nil
    }
    
    func config(with podcast: PTPodcast, loader: PTImageLoader) {
        imageTaskId = loader.loadImage(podcast.thumbnail) { [weak self] result in
            switch result {
                case .success(let data):
                    DispatchQueue.main.async {
                        self?.imageView.image = data
                    }
                case .failure:
                    break
                
            }
        }
    }
}
