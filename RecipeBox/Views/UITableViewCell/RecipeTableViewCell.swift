//
//  RecipeTableViewCell.swift
//  RecipeCollection
//
//  Created by Елена Русских on 2023-10-08.
//

import UIKit
import SnapKit

final class RecipeTableViewCell: UITableViewCell {
  
  // MARK: - Constants
  enum LayoutConstants {
      static let imageViewLeadingPadding: CGFloat = 15
      static let imageViewWidth: CGFloat = 100
      static let imageViewHeight: CGFloat = 100
      static let titleLabelLeadingPadding: CGFloat = 30
      static let titleLabelTrailingPadding: CGFloat = -15
      static let generalTopPadding: CGFloat = 10
      static let generalBottomPadding: CGFloat = -10
  }

  enum StyleConstants {
      static let cellTextColor = "linkBlue"
      static let cellFontSize: CGFloat = 22
      static let cellBackgroundViewColor = "softCream"
      static let cellBackgroundViewCornerRadius: CGFloat = 20.0
      static let identifier = "RecipeTableViewCell"
      static let shadowOpacity: Float = 0.2
      static let shadowOffset: CGSize = CGSize(width: 4, height: 4)
      static let shadowRadius: CGFloat = 4
  }
  
  // MARK: - UI Elements
   private let recipeImageView: UIImageView = {
      let imageView = UIImageView()
      imageView.contentMode = .scaleAspectFill
      imageView.clipsToBounds = true
      imageView.layer.cornerRadius = LayoutConstants.imageViewWidth / 2
      imageView.translatesAutoresizingMaskIntoConstraints = false
      return imageView
   }()
   
   private let titleLabel: UILabel = {
      let label = UILabel()
      label.numberOfLines = 0
      label.textColor = UIColor(named: StyleConstants.cellTextColor)
      label.font = UIFont.boldSystemFont(ofSize: StyleConstants.cellFontSize)
      label.translatesAutoresizingMaskIntoConstraints = false
      return label
   }()
   
   // MARK: - Initialization
   override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
      super.init(style: style, reuseIdentifier: reuseIdentifier)
      
      setupUI()
      setupConstraints()
   }
  
  required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Configuration Methods
  func configure(with recipe: Recipe, loadImage: @escaping (Recipe, @escaping (UIImage?) -> Void) -> Void) {
      titleLabel.text = recipe.title.capitalized
      
      loadImage(recipe) { [weak self] image in
          self?.recipeImageView.image = image
      }
      
      addShadow()
      let backgroundView = UIView()
      backgroundView.backgroundColor = UIColor(named: StyleConstants.cellBackgroundViewColor)
      backgroundView.layer.cornerRadius = StyleConstants.cellBackgroundViewCornerRadius
      backgroundView.clipsToBounds = true
      
      self.backgroundView = backgroundView
      self.backgroundColor = .clear
      self.contentView.backgroundColor = .clear
  }
  
  override func prepareForReuse() {
      super.prepareForReuse()
      
      titleLabel.text = nil
      recipeImageView.image = nil
      backgroundView = nil
      backgroundColor = .clear
      contentView.backgroundColor = .clear
  }
  
  // MARK: - Private Methods
  private func setupUI() {
      contentView.addSubview(recipeImageView)
      contentView.addSubview(titleLabel)
  }
  
  private func setupConstraints() {
      recipeImageView.snp.makeConstraints { make in
          make.leading.equalTo(contentView).offset(LayoutConstants.imageViewLeadingPadding)
          make.centerY.equalTo(contentView)
          make.width.equalTo(LayoutConstants.imageViewWidth)
          make.height.equalTo(LayoutConstants.imageViewHeight)
          make.top.greaterThanOrEqualTo(contentView).offset(LayoutConstants.generalTopPadding)
          make.bottom.lessThanOrEqualTo(contentView).offset(LayoutConstants.generalBottomPadding)
      }
      
      titleLabel.snp.makeConstraints { make in
          make.leading.equalTo(recipeImageView.snp.trailing).offset(LayoutConstants.titleLabelLeadingPadding)
          make.trailing.equalTo(contentView).offset(LayoutConstants.titleLabelTrailingPadding)
          make.centerY.equalTo(contentView)
          make.top.greaterThanOrEqualTo(contentView).offset(LayoutConstants.generalTopPadding)
          make.bottom.lessThanOrEqualTo(contentView).offset(LayoutConstants.generalBottomPadding)
      }
    }
  
  func addShadow() {
      layer.shadowColor = UIColor(named: StyleConstants.cellTextColor)?.cgColor
      layer.shadowOpacity = StyleConstants.shadowOpacity
      layer.shadowOffset = StyleConstants.shadowOffset
      layer.shadowRadius = StyleConstants.shadowRadius
      clipsToBounds = false
      contentView.clipsToBounds = false
  }
}
