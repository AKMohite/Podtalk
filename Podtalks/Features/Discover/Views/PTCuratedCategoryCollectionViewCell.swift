//
//  PTCuratedCategoryCollectionViewCell.swift
//  Podtalks
//
//  Created by Ashish Mohite + on 30/10/23.
//

import UIKit

class PTCuratedCategoryCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "PTCuratedCategoryCollectionViewCell"
    
    private let categoryName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 2
        label.textAlignment = .left
        label.clipsToBounds = true
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        return label
    }()
    private var podcastCollection: UICollectionView?
//    private let viewAll: UIButton = {
//        let button = UIButton()
//        button.translatesAutoresizingMaskIntoConstraints = false
//        button.setTitle("View all", for: .normal)
//        button.isHidden = true
//        button.backgroundColor = .purple
//        return button
//    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .secondarySystemBackground
        layer.cornerRadius = 8
        layer.masksToBounds = true
        let collectionView = createCollectionView()
        self.podcastCollection = collectionView
        contentView.addSubview(categoryName)
//        contentView.addSubview(viewAll)
        contentView.addSubview(collectionView)
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Not loaded for: PTCuratedCategoryCollectionViewCell")
    }
    
    private func addConstraints() {
        guard let collectionView = podcastCollection else { return }
        NSLayoutConstraint.activate([
            categoryName.topAnchor.constraint(equalTo: topAnchor, constant: 4),
            categoryName.leftAnchor.constraint(equalTo: leftAnchor, constant: 6),
            categoryName.rightAnchor.constraint(equalTo: rightAnchor, constant: -6),
//            categoryName.rightAnchor.constraint(equalTo: viewAll.leftAnchor, constant: -2),

//            viewAll.topAnchor.constraint(equalTo: topAnchor, constant: 4),
//            viewAll.rightAnchor.constraint(equalTo: rightAnchor, constant: -6)
            collectionView.topAnchor.constraint(equalTo: categoryName.bottomAnchor, constant: 2),
            collectionView.leftAnchor.constraint(equalTo: leftAnchor, constant: 6),
            collectionView.rightAnchor.constraint(equalTo: rightAnchor, constant: -6)
        ])
        
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    private func createCollectionView() -> UICollectionView {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: .init())
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collection.backgroundColor = .green
        return collection
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        categoryName.text = nil
//        viewAll.isHidden = true
    }
    
    func configure(with curatedCategory: CuratedPodcast) {
        categoryName.text = curatedCategory.title
//        viewAll.isHidden = !curatedCategory.canloadMore
    }
    
}

// MARK: - Collection view data source
extension PTCuratedCategoryCollectionViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.backgroundColor = .purple
        return cell
    }
}

// MARK: - Collection view delegate
extension PTCuratedCategoryCollectionViewCell: UICollectionViewDelegate {
    
}
