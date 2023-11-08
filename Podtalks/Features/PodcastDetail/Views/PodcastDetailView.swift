//
//  PodcastDetailView.swift
//  Podtalks
//
//  Created by Ashish Mohite + on 03/11/23.
//

import UIKit

class PodcastDetailView: UIView {
    
    private let progress: UIActivityIndicatorView = {
        let loader = UIActivityIndicatorView()
        loader.translatesAutoresizingMaskIntoConstraints = false
        loader.hidesWhenStopped = true
        loader.startAnimating()
        return loader
    }()
    private var collectionView: UICollectionView?
    private var detail: PTPodcastDetails?
    private let imageLoader = PTImageLoader()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .red
        let collectionView = createCollectionView()
        self.collectionView = collectionView
        addSubview(collectionView)
        addSubview(progress)
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Cannot load for: PodcastDetailView")
    }
    
    private func addConstraints() {
        guard let collectionView = self.collectionView else {
            return
        }
        NSLayoutConstraint.activate([
            progress.widthAnchor.constraint(equalToConstant: 100),
            progress.heightAnchor.constraint(equalToConstant: 100),
            progress.centerXAnchor.constraint(equalTo: centerXAnchor),
            progress.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            collectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            collectionView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
            
        ])
        
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    func load(with detail: PTPodcastDetails) {
        self.detail = detail
        progress.stopAnimating()
        collectionView?.reloadData()
    }
}

// MARK: - Setup collection view
extension PodcastDetailView {
    private func createCollectionView() -> UICollectionView {
        let layout = createCompositionalLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(PodcastDetailInfoReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: PodcastDetailInfoReusableView.identifier)
        collectionView.register(PodcastEpisodeCollectionViewCell.self, forCellWithReuseIdentifier: PodcastEpisodeCollectionViewCell.identifier)
        return collectionView
    }
    
    private func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
        let layout = UICollectionViewCompositionalLayout { _, _ in
            return self.createDetailSection()
        }
        
        return layout
    }
    
    private func createDetailSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0))
        )
        item.contentInsets = NSDirectionalEdgeInsets(top: 1, leading: 2, bottom: 1, trailing: 2)
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .absolute(60)
            ),
            repeatingSubitem: item,
            count: 1
        )
        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [
            NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .absolute(500)
                ),
                elementKind: UICollectionView.elementKindSectionHeader,
                alignment: .top
            )
        ]
        return section
    }
}

// MARK: - Collection view data source
extension PodcastDetailView: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return detail?.episodes.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PodcastEpisodeCollectionViewCell.identifier, for: indexPath) as? PodcastEpisodeCollectionViewCell, let episodes = detail?.episodes else {
            fatalError("Cannot create cell for \(PodcastEpisodeCollectionViewCell.identifier)")
        }
        let episode = episodes[indexPath.row]
        cell.configure(with: episode)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionHeader, let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: PodcastDetailInfoReusableView.identifier, for: indexPath) as? PodcastDetailInfoReusableView else {
            fatalError("Cannot form view for \(kind)")
        }
        if let info = detail?.info {
            header.configure(with: info, loader: imageLoader)
        }
        return header
    }
}

// MARK: - Collection view delegate
extension PodcastDetailView: UICollectionViewDelegate {
}
