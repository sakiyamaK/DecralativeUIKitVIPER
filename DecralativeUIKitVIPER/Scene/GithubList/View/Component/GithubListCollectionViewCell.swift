//
//  GithbuListCollectionCell.swift
//  DecralativeUIKitVIPER
//
//  Created by sakiyamaK on 2022/08/01.
//

import DeclarativeUIKit
import RxCocoa
import RxSwift
import UIKit

final class GithubListCollectionViewCell: UICollectionViewCell {
    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private let iconWidth: CGFloat = 40.0
    private let cellMargin: CGFloat = 8.0

    private weak var repoNameLabel: UILabel!
    private weak var ownerNameLabel: UILabel!
    private weak var ownerIconView: UIImageView!

    override init(frame: CGRect) {
        super.init(frame: frame)

        contentView.declarative {
            UIStackView.vertical {
                UIStackView.horizontal {
                    UIImageView(assign: &ownerIconView)
                        .contentMode(.scaleAspectFill)
                        .backgroundColor(.emptyBackgroundColor)
                        .width(iconWidth)
                        .aspectRatio(1.0)
                        .cornerRadius(20)
                        .customSpacing(8)

                    UIStackView.vertical {
                        UILabel(assign: &ownerNameLabel)
                            .contentHuggingPriority(.required, for: .vertical)
                            .font(UIFont.defaultNormalFont(size: 10))
                            .textColor(.secondTextColor)
                            .numberOfLines(1)
                            .customSpacing(8)

                        UILabel(assign: &repoNameLabel)
                            .contentHuggingPriority(.required, for: .vertical)
                            .font(UIFont.defaultBoldFont(size: 12))
                            .textColor(.secondTextColor)
                            .numberOfLines(1)
                    }
                }
                .alignment(.center)
                .padding(insets: .init(all: cellMargin))
                UIView.divider()
            }
        }
    }

    @discardableResult
    func configure(githubListEntity: GithubListEntity) -> Self {
        ownerIconView.kf.setImageWithBasicAuth(with: githubListEntity.owner.iconURLStr.url)
        ownerNameLabel.text = githubListEntity.owner.name
        repoNameLabel.text = githubListEntity.name
        return self
    }
}
