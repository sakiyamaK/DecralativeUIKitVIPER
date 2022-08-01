//
//  UICollectionViewCompositionalLayout+.swift
//  DecralativeUIKitVIPER
//
//  Created by sakiyamaK on 2022/07/18.
//

import UIKit.UICollectionViewLayout

extension UICollectionViewCompositionalLayout {
    static func verticalList(
        height: CGFloat,
        itemContentInsets: NSDirectionalEdgeInsets = .zero,
        groupContentInsets: NSDirectionalEdgeInsets = .zero,
        sectionContentInsets: NSDirectionalEdgeInsets = .zero
    ) -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { _, _ -> NSCollectionLayoutSection? in

            let itemSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .estimated(height)
            )
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = itemContentInsets

            let groupSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .estimated(height)
            )
            let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
            group.contentInsets = groupContentInsets

            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = sectionContentInsets

            return section
        }
    }

    static func horizontalList(
        width: CGFloat,
        itemContentInsets: NSDirectionalEdgeInsets = .zero,
        groupContentInsets: NSDirectionalEdgeInsets = .zero,
        sectionContentInsets: NSDirectionalEdgeInsets = .zero
    ) -> UICollectionViewCompositionalLayout {
        let configuration = UICollectionViewCompositionalLayoutConfiguration()
        configuration.scrollDirection = .horizontal

        let sectionProvider = { () -> NSCollectionLayoutSection in
            let itemSize = NSCollectionLayoutSize(
                widthDimension: .estimated(width),
                heightDimension: .fractionalHeight(1.0)
            )
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = itemContentInsets

            let groupSize = NSCollectionLayoutSize(
                widthDimension: .estimated(width),
                heightDimension: .fractionalHeight(1.0)
            )
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            group.contentInsets = groupContentInsets

            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = sectionContentInsets

            return section
        }()

        return UICollectionViewCompositionalLayout(section: sectionProvider, configuration: configuration)
    }
}
