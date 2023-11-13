//
//  PTSearchResultsView.swift
//  Podtalks
//
//  Created by Ashish Mohite + on 13/11/23.
//

import UIKit

class PTSearchResultsView: UIView {
    
    private var collectionView: UICollectionView?
    private var sections: [PTSearchResults] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        let collectionView = createCollectionView()
        self.collectionView = collectionView
        addSubview(collectionView)
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Cannot initialize for: PTSearchResultsView")
    }
    
    private func addConstraints() {
        guard let collectionView = collectionView else {
            return
        }
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leftAnchor.constraint(equalTo: leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func load(with results: [PTSearchResults]) {
        self.sections = results
        collectionView?.reloadData()
    }

}

// MARK: - create collection view
extension PTSearchResultsView {
    private func createCollectionView() -> UICollectionView {
        let layout = createCompositionalLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.register(PodcastEpisodeCollectionViewCell.self, forCellWithReuseIdentifier: PodcastEpisodeCollectionViewCell.identifier)
        return collectionView
    }
    
    private func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, _ in
            switch self.sections[sectionIndex] {
                case .podcasts: return self.getPodcastSection()
                case .episodes: return self.getEpisodeSection()
            }
        }
        return layout
    }
    
    private func getPodcastSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(1.0)
            )
        )
        item.contentInsets = NSDirectionalEdgeInsets(top: 4, leading: 4, bottom: 4, trailing: 4)
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .absolute(180),
                heightDimension: .absolute(180)
            ),
            subitems: [item]
        )
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        return section
    }
    
    private func getEpisodeSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0))
        )
        item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .absolute(65)
            ),
            repeatingSubitem: item,
            count: 1
        )
        let section = NSCollectionLayoutSection(group: group)
        return section
    }
}

// MARK: - Collection view data source
extension PTSearchResultsView: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let section = sections[section]
        switch section {
            case .podcasts(let podcasts): return podcasts.count
            case .episodes(let episodes): return episodes.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let section = sections[indexPath.section]
        switch section {
            case .podcasts(let podcasts):
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
            cell.backgroundColor = .red
            return cell
            case .episodes(let episodes):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PodcastEpisodeCollectionViewCell.identifier, for: indexPath) as? PodcastEpisodeCollectionViewCell else {
                fatalError("Cannot get episode cell for \(section)")
            }
            let episode = episodes[indexPath.row]
            cell.configure(with: episode)
            return cell
        }
    }
}

// MARK: - Collection view delegate
extension PTSearchResultsView: UICollectionViewDelegate {}
