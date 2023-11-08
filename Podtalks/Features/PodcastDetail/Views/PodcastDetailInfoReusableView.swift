//
//  PodcastDetailInfoReusableView.swift
//  Podtalks
//
//  Created by Ashish Mohite + on 03/11/23.
//

import UIKit

class PodcastDetailInfoReusableView: UICollectionReusableView {
    
    static let identifier = "PodcastDetailInfoReusableView"
    
    private let backgroundView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        let redValue = CGFloat(drand48())
        let greenValue = CGFloat(drand48())
        let blueValue = CGFloat(drand48())
            
        let randomColor = UIColor(red: redValue, green: greenValue, blue: blueValue, alpha: 0.8)
        view.backgroundColor = randomColor // TODO: Add image primary color after image is loaded
        return view
    }()
    private let podcastImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        image.layer.cornerRadius = 8
        image.layer.masksToBounds = true
        return image
    }()
    private let title: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.numberOfLines = 0
        return label
    }()
    private let podcastDescription: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.numberOfLines = 0
        return label
    }()
    private let genresStack: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .horizontal
        view.alignment = .leading
        view.distribution = UIStackView.Distribution.fillEqually
        return view
    }()
    private let favorite: UIButton = {
        var config = UIButton.Configuration.filled()
        config.title = "Add to library"
        config.buttonSize = .medium
        let button = UIButton(configuration: config)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    private var loader: PTImageLoader?
    private var imageTaskId: UUID?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(backgroundView)
        addSubview(podcastImage)
        addSubview(favorite)
        addSubview(title)
        addSubview(podcastDescription)
        addSubview(genresStack)
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Cannot load for: PodcastDetailInfoReusableView")
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            backgroundView.heightAnchor.constraint(equalToConstant: 100),
            backgroundView.topAnchor.constraint(equalTo: topAnchor),
            backgroundView.leftAnchor.constraint(equalTo: leftAnchor),
            backgroundView.rightAnchor.constraint(equalTo: rightAnchor),
            
            podcastImage.widthAnchor.constraint(equalToConstant: 150),
            podcastImage.heightAnchor.constraint(equalToConstant: 150),
            podcastImage.topAnchor.constraint(equalTo: topAnchor, constant: 30),
            podcastImage.leftAnchor.constraint(equalTo: leftAnchor, constant: 8),
//            podcastImage.rightAnchor.constraint(equalTo: rightAnchor, constant: 8),
            
            favorite.topAnchor.constraint(equalTo: backgroundView.bottomAnchor, constant: 8),
            favorite.rightAnchor.constraint(equalTo: rightAnchor, constant: -8),
            title.topAnchor.constraint(equalTo: podcastImage.bottomAnchor, constant: 4),
            title.leftAnchor.constraint(equalTo: leftAnchor, constant: 8),
            title.rightAnchor.constraint(equalTo: rightAnchor, constant: -8),
            
            podcastDescription.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 2),
            podcastDescription.leftAnchor.constraint(equalTo: leftAnchor, constant: 8),
            podcastDescription.rightAnchor.constraint(equalTo: rightAnchor, constant: -8),
            
            genresStack.topAnchor.constraint(equalTo: podcastDescription.bottomAnchor, constant: 2),
            genresStack.leftAnchor.constraint(equalTo: leftAnchor, constant: 8),
            genresStack.rightAnchor.constraint(equalTo: rightAnchor, constant: -8),
            genresStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
            
        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        podcastImage.image = nil
        if let id = imageTaskId {
            loader?.cancelLoad(id)
        }
        imageTaskId = nil
        title.text = nil
        podcastDescription.text = nil
        for btn in genresStack.subviews {
            btn.removeFromSuperview()
        }
    }
    
    func configure(with info: PTPodcastInfo, loader: PTImageLoader) {
        self.loader = loader
        imageTaskId = loader.loadImage(info.thumbnail) { [weak self] result in
            switch result {
                case .success(let data):
                    DispatchQueue.main.async {
                        self?.podcastImage.image = data
                    }
                case .failure:
                    break
                
            }
        }
        title.text = info.title
        podcastDescription.text = info.description
        for genre in info.genres {
            var config = UIButton.Configuration.bordered()
            config.title = genre.name
            config.buttonSize = .medium
            let button = UIButton(configuration: config)
            button.tag = genre.id
            button.addTarget(self, action: #selector(onGenreClick), for: .touchUpInside)
            genresStack.addArrangedSubview(button)
            genresStack.setCustomSpacing(8, after: button)
        }
    }
    
    @objc private func onGenreClick(_ sender: UIButton) {
        let genreId = sender.tag
        if genreId > 0 {
            print(genreId)
//            TODO: handle search by genre
        }
    }
        
}
