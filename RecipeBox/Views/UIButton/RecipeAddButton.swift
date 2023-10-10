//
//  RecipeAddButton.swift
//  RecipeCollection
//
//  Created by Елена Русских on 2023-10-08.
//

import UIKit

final class RecipeAddButton: UIButton {

    // MARK: - Constants
    private enum Constants {
        static let buttonTitle = "+"
        static let buttonTitleFont = UIFont.systemFont(ofSize: 24, weight: .bold)
        static let titleColor = UIColor.white
        static let cornerRadius: CGFloat = 20.0
    }

    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    private func setupView() {
        translatesAutoresizingMaskIntoConstraints = false
        setTitle(Constants.buttonTitle, for: .normal)
        titleLabel?.font = Constants.buttonTitleFont
        backgroundColor = Asset.activeGreen.color
        setTitleColor(Constants.titleColor, for: .normal)
        layer.cornerRadius = Constants.cornerRadius
        clipsToBounds = true
    }
}
