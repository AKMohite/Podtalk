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
            
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leftAnchor.constraint(equalTo: leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
            
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
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
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
            heightDimension: .fractionalWidth(1.0))
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
                    heightDimension: .fractionalWidth(1)
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.backgroundColor = .cyan
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionHeader, let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: PodcastDetailInfoReusableView.identifier, for: indexPath) as? PodcastDetailInfoReusableView else {
            fatalError("Cannot form view for \(kind)")
        }
        header.backgroundColor = .green
        return header
    }
}

// MARK: - Collection view delegate
extension PodcastDetailView: UICollectionViewDelegate {
}
