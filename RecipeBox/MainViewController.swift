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
  }

  lazy var rootView: MainRootView = {
      let view = MainRootView()
      view.tableView.delegate = self
      view.tableView.dataSource = self
      return view
  }()
  
  let firestoreService: RecipeServiceProtocol = FirestoreService()
  var recipes: [Recipe] = []
  
  override func loadView() {
      view = rootView
  }
  
  override func viewDidLoad() {
      super.viewDidLoad()
      loadRecipesFromService()
      setupUI()
    
  }

  private func setupUI() {
      view.backgroundColor = UIColor(named: "backgroundCream")
  }

  func loadRecipesFromService() {
          firestoreService.loadRecipes { [weak self] (recipes, error) in
              guard let strongSelf = self else { return }
              if let error = error {
                  print("Error getting documents: \(error)")
              } else if let recipes = recipes {
                  strongSelf.recipes = recipes
                  strongSelf.rootView.tableView.reloadData()
              }
          }
      }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension MainViewController: UITableViewDelegate, UITableViewDataSource {
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return recipes.count
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return Constants.numberOfRows
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      guard let cell = tableView.dequeueReusableCell(withIdentifier: RecipeTableViewCell.Constants.identifier, for: indexPath) as? RecipeTableViewCell else {
        return UITableViewCell()
        
      }
      let recipe = recipes[indexPath.section]
  
      cell.configure(with: recipe)
  
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


