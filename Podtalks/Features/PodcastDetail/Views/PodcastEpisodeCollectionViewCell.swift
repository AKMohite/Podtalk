//
//  PodcastEpisodeCollectionViewCell.swift
//  Podtalks
//
//  Created by Ashish Mohite + on 08/11/23.
//

import UIKit

class PodcastEpisodeCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "PodcastEpisodeCollectionViewCell"
    
    private let title: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    private let duration: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 12, weight: .medium)
        return label
    }()
    private let publishedDate: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        return label
    }()
    private let playButton: UIImageView = {
        let btn = UIImageView()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.image = UIImage(systemName: "play")
//        btn.layer.cornerRadius = 20
//        btn.layer.borderWidth = 1
        btn.layer.borderColor = UIColor.systemBlue.cgColor
        btn.layer.masksToBounds = true
        btn.contentMode = .scaleAspectFit
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .tertiarySystemBackground
        contentView.addSubview(title)
        contentView.addSubview(duration)
        contentView.addSubview(publishedDate)
        contentView.addSubview(playButton)
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Could not initialise for: PodcastEpisodeCollectionViewCell")
    }
    
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            playButton.widthAnchor.constraint(equalToConstant: 30),
            playButton.topAnchor.constraint(equalTo: contentView.topAnchor),
            playButton.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -4),
            playButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            publishedDate.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
            publishedDate.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 4),
            publishedDate.rightAnchor.constraint(equalTo: playButton.leftAnchor, constant: -4),
            
            title.topAnchor.constraint(equalTo: publishedDate.bottomAnchor, constant: 2),
            title.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 4),
            title.rightAnchor.constraint(equalTo: playButton.leftAnchor, constant: -4),
            
            duration.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 2),
            duration.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 4),
            duration.rightAnchor.constraint(equalTo: playButton.leftAnchor, constant: -4),
            duration.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4)
            
        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        title.text = nil
        duration.text = nil
        publishedDate.text = nil
    }
    
    func configure(with episode: PTEpisode) {
        title.text = episode.title
        duration.text = episode.duration
        publishedDate.text = episode.publishedDate.formatted()
    }
    
}
