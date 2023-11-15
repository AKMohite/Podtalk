//
//  PTEpisodeDetailView.swift
//  Podtalks
//
//  Created by Ashish Mohite + on 14/11/23.
//

import UIKit

protocol PTEpisodeDetailViewDelegate: AnyObject {
    func ptEpisodeDetailView(_ detailView: PTEpisodeDetailView, didTap podcast: PTPodcast)
}

class PTEpisodeDetailView: UIView {
    
    weak var delegate: PTEpisodeDetailViewDelegate?
    private let imageLoader = PTImageLoader()
    private var imageTaskId: UUID?
    private var details: PTEpisodeDetail?
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
    private let podcastTitle: UIButton = {
        var filled = UIButton.Configuration.borderless()
        filled.buttonSize = .medium
        filled.image = UIImage(systemName: "chevron.right")
        filled.imagePlacement = .trailing
        filled.imagePadding = 5
        let btn = UIButton(configuration: filled, primaryAction: nil)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
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
    private let publishedDate: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .thin)
        label.numberOfLines = 1
        return label
    }()
    private let duration: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .thin)
        label.numberOfLines = 1
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
        addSubview(publishedDate)
        addSubview(duration)
        addConstraints()
        podcastTitle.addTarget(self, action: #selector(onPodcastTap), for: .touchUpInside)
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
    
    @objc
    private func onPodcastTap(_ sender: UIButton) {
        if let podcast = details?.podcast {
            delegate?.ptEpisodeDetailView(self, didTap: podcast)
        }
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            bgView.heightAnchor.constraint(equalToConstant: 100),
            bgView.topAnchor.constraint(equalTo: topAnchor),
            bgView.leftAnchor.constraint(equalTo: leftAnchor),
            bgView.rightAnchor.constraint(equalTo: rightAnchor),
            
            episodeImg.widthAnchor.constraint(equalToConstant: 150),
            episodeImg.heightAnchor.constraint(equalToConstant: 150),
            episodeImg.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            episodeImg.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            title.topAnchor.constraint(equalTo: episodeImg.bottomAnchor, constant: 8),
            title.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            title.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),
            
            podcastTitle.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 8),
            podcastTitle.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            podcastTitle.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),
            
            publishedDate.topAnchor.constraint(equalTo: podcastTitle.bottomAnchor, constant: 12),
            publishedDate.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            
            duration.topAnchor.constraint(equalTo: podcastTitle.bottomAnchor, constant: 12),
            duration.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            
            desc.topAnchor.constraint(equalTo: publishedDate.bottomAnchor, constant: 8),
            desc.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            desc.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
        ])
    }
    
    func configure(with details: PTEpisodeDetail) {
        self.details = details
        let episode = details.episode
        let podcast = details.podcast
        title.text = episode.title
        desc.text = episode.description.htmlToString
        publishedDate.text = episode.publishedDate.formatted()
        duration.text = episode.duration
        podcastTitle.setTitle(podcast.name, for: .normal)
        podcastTitle.tintColor = bgView.backgroundColor
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
