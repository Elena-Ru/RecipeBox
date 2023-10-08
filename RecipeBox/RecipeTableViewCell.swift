//
//  RecipeTableViewCell.swift
//  RecipeCollection
//
//  Created by Елена Русских on 2023-10-08.
//

import UIKit

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
      static let cellTextColorName = "linkBlue"
      static let cellFontSize: CGFloat = 22
      static let cellBackgroundViewColorName = "softCream"
      static let cellBackgroundViewCornerRadius: CGFloat = 20.0
      static let identifier = "RecipeTableViewCell"
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
      label.textColor = UIColor(named: StyleConstants.cellTextColorName)
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
  func configure(with recipe: Recipe) {
      titleLabel.text = recipe.title
      loadImage(from: recipe.photo)
      
      let backgroundView = UIView()
      backgroundView.backgroundColor = UIColor(named: StyleConstants.cellBackgroundViewColorName)
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
      NSLayoutConstraint.activate([
        recipeImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: LayoutConstants.imageViewLeadingPadding),
        recipeImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
        recipeImageView.widthAnchor.constraint(equalToConstant: LayoutConstants.imageViewWidth),
        recipeImageView.heightAnchor.constraint(equalToConstant: LayoutConstants.imageViewHeight),
        recipeImageView.topAnchor.constraint(greaterThanOrEqualTo: contentView.topAnchor, constant: LayoutConstants.generalTopPadding),
        recipeImageView.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: LayoutConstants.generalBottomPadding),
        
        titleLabel.leadingAnchor.constraint(equalTo: recipeImageView.trailingAnchor, constant: LayoutConstants.titleLabelLeadingPadding),
        titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: LayoutConstants.titleLabelTrailingPadding),
        titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
        titleLabel.topAnchor.constraint(greaterThanOrEqualTo: contentView.topAnchor, constant: LayoutConstants.generalTopPadding),
        titleLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: LayoutConstants.generalBottomPadding)
      ])
    }
  
  private func loadImage(from urlString: String) {
    if let url = URL(string: urlString) {
      DispatchQueue.global().async {
        if let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
          DispatchQueue.main.async {
            self.recipeImageView.image = image
            print("Image successfully loaded and set.")
          }
        } else {
          print("Failed to load data from the URL.")
        }
      }
    } else {
      print("Invalid URL string: \(urlString)")
      recipeImageView.image = nil
    }
  }
}
