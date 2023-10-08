//
//  RecipeTableViewCell.swift
//  RecipeCollection
//
//  Created by Елена Русских on 2023-10-08.
//

import UIKit

final class RecipeTableViewCell: UITableViewCell {
  
  enum Constants {
      static let cellTextColorName = "linkBlue"
      static let cellFontSize: CGFloat = 18
      static let cellBackgroundViewColorName = "softCream"
      static let cellBackgroundViewCornerRadius: CGFloat = 20.0
      static let identifier = "RecipeTableViewCell"
  }

    func configure(with recipe: Recipe) {
        textLabel?.text = recipe.title
        textLabel?.textColor = UIColor(named: Constants.cellTextColorName)
        textLabel?.font = UIFont.boldSystemFont(ofSize: Constants.cellFontSize)

        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor(named: Constants.cellBackgroundViewColorName)
        backgroundView.layer.cornerRadius = Constants.cellBackgroundViewCornerRadius
        backgroundView.clipsToBounds = true

        self.backgroundView = backgroundView
        self.backgroundColor = .clear
        self.contentView.backgroundColor = .clear
    }
  
    override func prepareForReuse() {
        super.prepareForReuse()
      
        textLabel?.text = nil
        textLabel?.textColor = nil
        textLabel?.font = nil
        backgroundView = nil
        backgroundColor = .clear
        contentView.backgroundColor = .clear
    }
}
