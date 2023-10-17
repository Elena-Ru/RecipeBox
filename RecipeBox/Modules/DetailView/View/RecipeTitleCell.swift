//
//  RecipeTitleCell.swift
//  RecipeBox
//
//  Created by Елена Русских on 2023-10-17.
//

import UIKit
import SnapKit

class RecipeTitleCell: UICollectionViewCell {
    static let identifier = "RecipeTitleCell"
  
    private struct Constants {
        static let font = UIFont.systemFont(ofSize: 24, weight: .bold)
        static let edgeInsets = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
    }
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.font
        label.textColor = Asset.darkGreenText.color
        label.numberOfLines = .zero
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(Constants.edgeInsets)
        }
    }
}
