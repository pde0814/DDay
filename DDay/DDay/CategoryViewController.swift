//
//  CategoryViewController.swift
//  DDay
//
//  Created by 박동언 on 5/27/25.
//

import UIKit

class CategoryViewController: UIViewController {
    @IBOutlet weak var categoryCollectionView: UICollectionView!

    func setupLayout() {
        // item size
        let size = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.33), heightDimension: .estimated(120))
        let item = NSCollectionLayoutItem(layoutSize: size)

        // group size
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(120))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.interItemSpacing = .flexible(20)

        // section
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20)
        section.interGroupSpacing = 20

        // layout
        let layout = UICollectionViewCompositionalLayout(section: section)
        categoryCollectionView.collectionViewLayout = layout
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupLayout()
        isModalInPresentation = true

    }

}

extension CategoryViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Event.Category.allCases.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: CategoryCollectionViewCell.self), for: indexPath) as! CategoryCollectionViewCell

        let target = Event.Category.allCases[indexPath.item] // row 대신 item
        cell.titleLabel.text = target.title
        cell.categoryImageView.image = UIImage(named: target.rawValue)

        return cell
    }


}
