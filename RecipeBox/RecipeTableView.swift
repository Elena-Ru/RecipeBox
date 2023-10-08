//
//  RecipeTableView.swift
//  RecipeCollection
//
//  Created by Елена Русских on 2023-10-08.
//

import UIKit

final class RecipeTableView: UITableView {
    
    // MARK: - Constants
    private enum Constants {
        static let cellIdentifier = RecipeTableViewCell.identifier
        static let backgroundColorName = "backgroundCream"
        static let sectionCornerRadius: CGFloat = 20.0
    }

    // MARK: - Initializers
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    private func setupView() {
        translatesAutoresizingMaskIntoConstraints = false
        register(RecipeTableViewCell.self, forCellReuseIdentifier: Constants.cellIdentifier)
        tableFooterView = UIView()
        backgroundColor = UIColor(named: Constants.backgroundColorName)
        contentInset = .zero
        layer.cornerRadius = Constants.sectionCornerRadius
        separatorStyle = .none
        clipsToBounds = true
    }
}
