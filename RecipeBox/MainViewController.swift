//
//  ViewController.swift
//  RecipeCollection
//
//  Created by Елена Русских on 2023-10-08.
//

import UIKit

final class MainViewController: UIViewController {
  
  struct Constants {
      static let numberOfSections = 5
      static let numberOfRows = 1
      static let footerHeight: CGFloat = 10.0
      static let cellText = "text some"
      static let cellTextColorName = "linkBlue"
      static let cellFontSize: CGFloat = 18
      static let cellBackgroundViewColorName = "softCream"
      static let cellBackgroundViewCornerRadius: CGFloat = 20.0
  }

  lazy var rootView: MainRootView = {
      let view = MainRootView()
      view.tableView.delegate = self
      view.tableView.dataSource = self
      return view
  }()
  
  override func loadView() {
      view = rootView
  }
  
  override func viewDidLoad() {
      super.viewDidLoad()
      setupUI()
  }

  private func setupUI() {
      view.backgroundColor = UIColor(named: "backgroundCream")
  }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension MainViewController: UITableViewDelegate, UITableViewDataSource {
  
  func numberOfSections(in tableView: UITableView) -> Int {
      return Constants.numberOfSections
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return Constants.numberOfRows
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      guard let cell = tableView.dequeueReusableCell(withIdentifier: RecipeTableViewCell.identifier, for: indexPath) as? RecipeTableViewCell else {
        return UITableViewCell()
        
      }
    
      cell.configure()
  
      return cell
  }

  func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
      return Constants.footerHeight
  }

  func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
      let footer = UIView()
      footer.backgroundColor = .clear
      return footer
  }
}


