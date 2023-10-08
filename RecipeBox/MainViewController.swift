//
//  ViewController.swift
//  RecipeCollection
//
//  Created by Елена Русских on 2023-10-08.
//

import UIKit
import Firebase
import FirebaseFirestore


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
  
  override func loadView() {
      view = rootView
  }
  
  override func viewDidLoad() {
      super.viewDidLoad()
      loadRecipes()
      setupUI()
    
  }

  private func setupUI() {
      view.backgroundColor = UIColor(named: "backgroundCream")
  }
  
  let db = Firestore.firestore()
  var recipes: [Recipe] = []

  func loadRecipes() {
      db.collection("recipes").getDocuments { (snapshot, error) in
          if let error = error {
              print("Error getting documents: \(error)")
          } else {
              self.recipes = snapshot!.documents.map { (document) -> Recipe in
                  let data = document.data()
                  let id = document.documentID
                  let title = data["title"] as? String ?? ""
                  return Recipe(id: id, title: title)
              }
              self.rootView.tableView.reloadData()
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


