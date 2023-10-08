//
//  MainRootView.swift
//  RecipeCollection
//
//  Created by Елена Русских on 2023-10-08.
//

import UIKit

final class MainRootView: UIView {
  
  // MARK: - UI Components
  let tableView = RecipeTableView()
  let searchBar = RecipeSearchBar()
  let addButton = RecipeAddButton()

  // MARK: - Constants
  private enum LayoutConstants {
      static let topMargin: CGFloat = 10
      static let leadingMargin: CGFloat = 20
      static let trailingMargin: CGFloat = -20
      static let spacingBetweenViews: CGFloat = 10
      static let searchBarHeight: CGFloat = 50
  }

  // MARK: - Initializers
  init() {
      super.init(frame: CGRect())
      setupLayout()
  }
  
  required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Setup
  private func setupLayout() {
      addSubviews()
      activateConstraints()
  }
  
  private func addSubviews() {
      addSubview(tableView)
      addSubview(searchBar)
      addSubview(addButton)
  }
  
  private func activateConstraints() {
      NSLayoutConstraint.activate([
        searchBar.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: LayoutConstants.topMargin),
        searchBar.leadingAnchor.constraint(equalTo: leadingAnchor, constant: LayoutConstants.leadingMargin),
        searchBar.trailingAnchor.constraint(equalTo: addButton.leadingAnchor, constant: -LayoutConstants.spacingBetweenViews),
        searchBar.heightAnchor.constraint(equalToConstant: LayoutConstants.searchBarHeight),

        addButton.widthAnchor.constraint(equalTo: addButton.heightAnchor),
        addButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: LayoutConstants.trailingMargin),
        addButton.centerYAnchor.constraint(equalTo: searchBar.centerYAnchor),
        addButton.heightAnchor.constraint(equalTo: searchBar.heightAnchor),
        
        tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: LayoutConstants.spacingBetweenViews),
        tableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: LayoutConstants.leadingMargin),
        tableView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: LayoutConstants.trailingMargin),
        tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
      ])
  }
}

