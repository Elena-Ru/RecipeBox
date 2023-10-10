//
//  RecipeSearchBar.swift
//  RecipeCollection
//
//  Created by Елена Русских on 2023-10-08.
//

import UIKit

final class RecipeSearchBar: UISearchBar {

    // MARK: - Constants
    private enum Constants {
        static let placeholderText = L10n.search
        static let searchFieldKey = "searchField"
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
        placeholder = Constants.placeholderText
        sizeToFit()
        backgroundImage = UIImage()

        if let textField = value(forKey: Constants.searchFieldKey) as? UITextField {
            textField.backgroundColor = Asset.lightCreamTextField.color
            textField.textColor = Asset.darkGreenText.color
        }
    }
}
