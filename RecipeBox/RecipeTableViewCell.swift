//
//  RecipeTableViewCell.swift
//  RecipeCollection
//
//  Created by Елена Русских on 2023-10-08.
//

import UIKit

final class RecipeTableViewCell: UITableViewCell {

    static let identifier = "RecipeTableViewCell"

    func configure() {
        textLabel?.text = MainViewController.Constants.cellText
        textLabel?.textColor = UIColor(named: MainViewController.Constants.cellTextColorName)
        textLabel?.font = UIFont.boldSystemFont(ofSize: MainViewController.Constants.cellFontSize)

        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor(named: MainViewController.Constants.cellBackgroundViewColorName)
        backgroundView.layer.cornerRadius = MainViewController.Constants.cellBackgroundViewCornerRadius
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
