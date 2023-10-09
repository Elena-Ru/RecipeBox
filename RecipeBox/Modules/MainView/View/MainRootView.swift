//
//  MainRootView.swift
//  RecipeCollection
//
//  Created by Елена Русских on 2023-10-08.
//

import UIKit
import SnapKit

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
       searchBar.snp.makeConstraints { make in
           make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(LayoutConstants.topMargin)
           make.leading.equalToSuperview().offset(LayoutConstants.leadingMargin)
           make.trailing.equalTo(addButton.snp.leading).offset(-LayoutConstants.spacingBetweenViews)
           make.height.equalTo(LayoutConstants.searchBarHeight)
       }

       addButton.snp.makeConstraints { make in
           make.width.equalTo(addButton.snp.height)
           make.trailing.equalToSuperview().offset(LayoutConstants.trailingMargin)
           make.centerY.equalTo(searchBar.snp.centerY)
           make.height.equalTo(searchBar.snp.height)
       }
       
       tableView.snp.makeConstraints { make in
           make.top.equalTo(searchBar.snp.bottom).offset(LayoutConstants.spacingBetweenViews)
           make.leading.equalToSuperview().offset(LayoutConstants.leadingMargin)
           make.trailing.equalToSuperview().offset(LayoutConstants.trailingMargin)
           make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom)
       }
   }
}
