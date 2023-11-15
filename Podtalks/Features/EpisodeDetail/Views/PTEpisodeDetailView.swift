//
//  PTEpisodeDetailView.swift
//  Podtalks
//
//  Created by Ashish Mohite + on 14/11/23.
//

import UIKit

class PTEpisodeDetailView: UIView {
    
    private let imageLoader = PTImageLoader()
    private var imageTaskId: UUID?
    private let bgView: UIView = {
        let uiView = UIView()
        uiView.translatesAutoresizingMaskIntoConstraints = false
        let redValue = CGFloat(drand48())
        let greenValue = CGFloat(drand48())
        let blueValue = CGFloat(drand48())
        let randomColor = UIColor(red: redValue, green: greenValue, blue: blueValue, alpha: 0.8)
        uiView.backgroundColor = randomColor // TODO: Add image primary color after image is loaded
        return uiView
    }()
    private let episodeImg: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.contentMode = .scaleAspectFit
        img.clipsToBounds = true
        img.layer.cornerRadius = 8
        img.layer.masksToBounds = true
        return img
    }()
    private let podcastTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    private let title: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    private let desc: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.numberOfLines = 0
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(bgView)
        addSubview(episodeImg)
        addSubview(podcastTitle)
        addSubview(title)
        addSubview(desc)
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Cannot load for: PTEpisodeDetailView")
    }
    
    deinit {
        episodeImg.image = nil
        if let id = imageTaskId {
            imageLoader.cancelLoad(id)
        }
        imageTaskId = nil
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            bgView.heightAnchor.constraint(equalToConstant: 100),
            bgView.topAnchor.constraint(equalTo: topAnchor),
            bgView.leftAnchor.constraint(equalTo: leftAnchor),
            bgView.rightAnchor.constraint(equalTo: rightAnchor),
            
            episodeImg.widthAnchor.constraint(equalToConstant: 150),
            episodeImg.heightAnchor.constraint(equalToConstant: 150),
            episodeImg.topAnchor.constraint(equalTo: topAnchor, constant: 40),
            episodeImg.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            title.topAnchor.constraint(equalTo: episodeImg.bottomAnchor, constant: 8),
            title.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            title.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),
            
            podcastTitle.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 8),
            podcastTitle.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            podcastTitle.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),
        ])
    }
    
    func configure(with details: PTEpisodeDetail) {
        let episode = details.episode
        let podcast = details.podcast
        title.text = episode.title
        podcastTitle.text = podcast.name
        podcastTitle.textColor = bgView.backgroundColor ?? .systemIndigo
        imageTaskId = imageLoader.loadImage(episode.thumbnail) { [weak self] result in
            switch result {
                case .success(let data):
                    DispatchQueue.main.async {
                        self?.episodeImg.image = data
                    }
                case .failure:
                    break
                
            }
        }
    }
    
}
