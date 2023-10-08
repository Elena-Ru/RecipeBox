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
  
  let recipeImageURLs: [String: String] = [
      "Mojito": "https://firebasestorage.googleapis.com/v0/b/recipebox-7a825.appspot.com/o/%D0%BC%D0%BE%D1%85%D0%B8%D1%82%D0%BE.jpeg?alt=media&token=213e30e4-bf56-46f5-854c-02bd72820c0d",
      "Tea": "https://firebasestorage.googleapis.com/v0/b/recipebox-7a825.appspot.com/o/tea.jpeg?alt=media&token=61cded61-bae6-41ed-bbb7-39795cd1327e",
      "Hurricane cocktail": "https://firebasestorage.googleapis.com/v0/b/recipebox-7a825.appspot.com/o/hurricane_cocktail.jpeg?alt=media&token=cfad76cd-a5fa-4d5c-b811-280cc1ee56f6"
  ]

  
  override func loadView() {
      view = rootView
  }
  
  override func viewDidLoad() {
      super.viewDidLoad()
      firestoreService.addIngredientsToRecipes()
      firestoreService.updateRecipesWithImageURLs(recipeImageURLs: recipeImageURLs) { (error) in
          if let error = error {
              print("Ошибка обновления: \(error.localizedDescription)")
          } else {
              print("Документы успешно обновлены!")
          }
      }
      loadRecipesFromService()
      setupUI()
    rootView.tableView.estimatedRowHeight = 120 // Предполагаемая высота
    rootView.tableView.rowHeight = UITableView.automaticDimension // Автоматический расчет высоты
    
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
      guard let cell = tableView.dequeueReusableCell(withIdentifier: RecipeTableViewCell.StyleConstants.identifier, for: indexPath) as? RecipeTableViewCell else {
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


