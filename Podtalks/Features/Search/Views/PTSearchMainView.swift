//
//  PTSearchMainView.swift
//  Podtalks
//
//  Created by Ashish Mohite + on 08/11/23.
//

import UIKit

protocol PTSearchMainViewDelegate: AnyObject {
    func ptSearchMainView(_ searchView: PTSearchMainView, didSelectItem genre: TalkGenre)
}

class PTSearchMainView: UIView {
    
    weak var delegate: PTSearchMainViewDelegate?
    private let collectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewCompositionalLayout(sectionProvider: { _, _ in
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(0.5),
                heightDimension: .fractionalHeight(1)
            )
        )
        item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .absolute(80)
            ),
            repeatingSubitem: item,
            count: 2
        )
        let section = NSCollectionLayoutSection(group: group)
        return section
    }))
    private var genres: [TalkGenre] = []
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .systemBackground
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(collectionView)
        collectionView.register(PTGenreCollectionViewCell.self, forCellWithReuseIdentifier: PTGenreCollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Cannot initialise for: PTSearchMainView")
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leftAnchor.constraint(equalTo: leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func reload(with genres: [TalkGenre]) {
        self.genres = genres
        collectionView.reloadData()
    }
    
}

// MARK: - Collection view data source
extension PTSearchMainView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return genres.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PTGenreCollectionViewCell.identifier, for: indexPath) as? PTGenreCollectionViewCell else {
            fatalError("Cannot get cell for search by genres")
        }
        let genre = genres[indexPath.row]
        cell.configure(with: genre)
        return cell
    }
}

// MARK: - Collection view delegate
extension PTSearchMainView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let genre = genres[indexPath.row]
        delegate?.ptSearchMainView(self, didSelectItem: genre)
    }
}
