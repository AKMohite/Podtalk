//
//  PTPodcastCollectionViewCell.swift
//  Podtalks
//
//  Created by Ashish Mohite + on 30/10/23.
//

import UIKit

class PTPodcastCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "PTPodcastCollectionViewCell"
    
    private var loader: PTImageLoader?
    private var imageTaskId: UUID?
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
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        return label
    }()
    private let publishedBy: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        label.font = .systemFont(ofSize: 14, weight: .regular)
        return label
    }()
    private let episodeCount: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 12, weight: .thin)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .tertiarySystemBackground
        contentView.layer.masksToBounds = true
        contentView.layer.cornerRadius = 8
        contentView.addSubview(podcastImg)
        contentView.addSubview(podcastName)
        contentView.addSubview(publishedBy)
        contentView.addSubview(episodeCount)
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Not loaded view: PTPodcastCollectionViewCell")
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            podcastImg.widthAnchor.constraint(equalToConstant: 100),
            podcastImg.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
            podcastImg.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4),
            podcastImg.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 4),
            
            podcastName.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
            podcastName.leftAnchor.constraint(equalTo: podcastImg.rightAnchor, constant: 4),
            podcastName.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -4),
            
            publishedBy.topAnchor.constraint(equalTo: podcastName.bottomAnchor, constant: 4),
            publishedBy.leftAnchor.constraint(equalTo: podcastImg.rightAnchor, constant: 4),
            publishedBy.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -4),
            
            episodeCount.topAnchor.constraint(equalTo: publishedBy.bottomAnchor),
            episodeCount.leftAnchor.constraint(equalTo: podcastImg.rightAnchor, constant: 4),
            episodeCount.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -4)

        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        podcastImg.image = nil
        if let id = imageTaskId {
            loader?.cancelLoad(id)
        }
        imageTaskId = nil
        podcastName.text = nil
        publishedBy.text = nil
        episodeCount.text = nil
    }
    
    func configure(with podcast: PTPodcast, loader: PTImageLoader) {
        self.loader = loader
        podcastName.text = podcast.name
        publishedBy.text = podcast.publishedBy ?? "NA"
        episodeCount.text = "Episodes: \(podcast.numberOfEpisodes)"
        imageTaskId = loader.loadImage(podcast.thumbnail) { [weak self] result in
            switch result {
                case .success(let data):
                    DispatchQueue.main.async {
                        self?.podcastImg.image = data
                    }
                case .failure:
                    break
                
            }
        }
    }
}
