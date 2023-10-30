//
//  PTDiscoverMainView.swift
//  Podtalks
//
//  Created by Ashish Mohite + on 28/10/23.
//

import UIKit

class PTDiscoverMainView: UIView {
    
    private let loader: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.hidesWhenStopped = true
        return spinner
    }()
    private var collectionView: UICollectionView?
    private var sections: [DiscoverUISection] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .systemBackground
        
        let collectionView = createCollectionView()
        self.collectionView = collectionView
        
        addSubview(loader)
        addSubview(collectionView)
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Not loaded by: PTDiscoverMainView")
    }
    
    func reloadData(for sections: [DiscoverUISection]) {
        self.sections = sections
        collectionView?.reloadData()
    }
    
    private func addConstraints() {
        guard let collectionView = collectionView else { return }
        
        NSLayoutConstraint.activate([
            
            loader.widthAnchor.constraint(equalToConstant: 100),
            loader.heightAnchor.constraint(equalToConstant: 100),
            loader.centerXAnchor.constraint(equalTo: centerXAnchor),
            loader.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leftAnchor.constraint(equalTo: leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}

// MARK: Setup collection section skeleton
extension PTDiscoverMainView {
    private func createCollectionView() -> UICollectionView {
        let layout = createComposationalLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.register(PTDiscoverHeaderCollectionViewCell.self, forCellWithReuseIdentifier: PTDiscoverHeaderCollectionViewCell.identifier)
        return collectionView
    }
    
    private func createComposationalLayout() -> UICollectionViewCompositionalLayout {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, _ in
            return self.createSection(for: sectionIndex)
        }
        return layout
    }
    
    private func createSection(for index: Int) -> NSCollectionLayoutSection {
        switch sections[index] {
        case .topBanners: return createTopBannerLayout()
        case .bestPodcasts: return createBestPodcastsLayout()
        case .recentAddedPodcasts: return createRecentAddedPodcastLayout()
        case .curatedList: return createCuratedListLayout()
        }
    }
}

// MARK: - Discover section layout
extension PTDiscoverMainView {
    private func createTopBannerLayout() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(1.0)
            )
        )
        item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 16, bottom: 10, trailing: 16)
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .absolute(150)
            ),
            subitems: [item]
        )
        let section = NSCollectionLayoutSection(group: group)
        section.visibleItemsInvalidationHandler = { (items, offset, environment) in
             items.forEach { item in
             let distanceFromCenter = abs((item.frame.midX - offset.x) - environment.container.contentSize.width / 2.0)
             let minScale: CGFloat = 0.8
             let maxScale: CGFloat = 1.0
             let scale = max(maxScale - (distanceFromCenter / environment.container.contentSize.width), minScale)
             item.transform = CGAffineTransform(scaleX: scale, y: scale)
             }
        }
        section.orthogonalScrollingBehavior = .paging
        return section
    }
    
    private func createBestPodcastsLayout() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(1.0)
            )
        )
        item.contentInsets = NSDirectionalEdgeInsets(top: 4, leading: 2, bottom: 4, trailing: 2)
        let verticalGroup = NSCollectionLayoutGroup.vertical(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .absolute(300)
            ),
            repeatingSubitem: item,
            count: 4
        )
//        verticalGroup.interItemSpacing = .flexible(4)
        verticalGroup.contentInsets = NSDirectionalEdgeInsets(top: 4, leading: 2, bottom: 4, trailing: 2)
        let horizontalGroup = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(0.9),
                heightDimension: .absolute(300)
            ),
            repeatingSubitem: verticalGroup,
            count: 1
        )
        let section = NSCollectionLayoutSection(group: horizontalGroup)
        section.orthogonalScrollingBehavior = .groupPaging
        return section
    }
    
    private func createRecentAddedPodcastLayout() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(1.0)
            )
        )
        item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
        let verticalGroup = NSCollectionLayoutGroup.vertical(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .absolute(300)
            ),
            subitems: [item, item, item, item]
        )
        let horizontalGroup = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(0.9),
                heightDimension: .absolute(300)
            ),
            subitems: [verticalGroup]
        )
        let section = NSCollectionLayoutSection(group: horizontalGroup)
        section.orthogonalScrollingBehavior = .groupPaging
        return section
    }
    
    private func createCuratedListLayout() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(1.0)
            )
        )
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0)
        let verticalGroup = NSCollectionLayoutGroup.vertical(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .absolute(150)
            ),
            subitems: [item]
        )
        let section = NSCollectionLayoutSection(group: verticalGroup)
        return section
    }
}

// MARK: - Collection delegate
extension PTDiscoverMainView: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let section = sections[indexPath.section]
        switch section {
        case .topBanners(let podcasts):
            let podcast = podcasts[indexPath.row]
            self.gotoPodcastDetails(podcast: podcast)
            break
        case .bestPodcasts(let podcasts):
            let podcast = podcasts[indexPath.row]
            self.gotoPodcastDetails(podcast: podcast)
            break
        case .recentAddedPodcasts(let podcasts):
            let podcast = podcasts[indexPath.row]
            self.gotoPodcastDetails(podcast: podcast)
            break
        case .curatedList(let curatedList):
            let curatedPodcast = curatedList[indexPath.row]
            self.gotoCuratedPodcast(curatedPodcast: curatedPodcast)
            break
        }
    }
    
    private func gotoPodcastDetails(podcast: PTPodcast) {
        
    }
    
    private func gotoCuratedPodcast(curatedPodcast: CuratedPodcast) {}
    
}

// MARK: - Collection data source
extension PTDiscoverMainView: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch sections[section] {
            case .topBanners(let banners): return banners.count
            case .bestPodcasts(let podcasts): return podcasts.count
            case .recentAddedPodcasts(let podcasts): return podcasts.count
            case .curatedList(let curatedList): return curatedList.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let section = sections[indexPath.section]
        switch section {
            case .topBanners(let podcasts):
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PTDiscoverHeaderCollectionViewCell.identifier, for: indexPath) as? PTDiscoverHeaderCollectionViewCell else {
                    fatalError("Cannot create cell for: \(section)")
                }
                let podcast = podcasts[indexPath.row]
                cell.configure(with: podcast)
                return cell
            case .bestPodcasts:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
                cell.backgroundColor = .systemRed
                return cell
            case .recentAddedPodcasts:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
                cell.backgroundColor = .systemBlue
                return cell
            case .curatedList:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
                cell.backgroundColor = .systemIndigo
                return cell
        }
    }
    
    
}
