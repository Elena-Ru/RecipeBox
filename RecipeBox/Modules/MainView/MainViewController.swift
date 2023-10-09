//
//  ViewController.swift
//  RecipeCollection
//
//  Created by Елена Русских on 2023-10-08.
//

import UIKit

protocol MainViewProtocol: AnyObject {
    func displayRecipes(_ recipes: [Recipe])
    func showError(_ error: String)
}

final class MainViewController: UIViewController, MainViewProtocol {

  struct Constants {
      static let numberOfSections = 5
      static let numberOfRows = 1
      static let footerHeight: CGFloat = 10.0
      static let cellHeight: CGFloat = 120
  }

  lazy var rootView: MainRootView = {
      let view = MainRootView()
      view.tableView.delegate = self
      view.tableView.dataSource = self
      return view
  }()
  private var presenter: MainViewPresenter!
  let imageService: ImageServiceProtocol = KingfisherImageService()
  let firestoreService: RecipeServiceProtocol = FirestoreService()
  var recipes: [Recipe] = []

  override func loadView() {
      view = rootView
  }
  
  override func viewDidLoad() {
      super.viewDidLoad()
    
      presenter = MainViewPresenter(
        view: self,
        firestoreService: firestoreService,
        imageService: imageService
      )
      loadRecipesFromService()
      setupUI()
      rootView.tableView.estimatedRowHeight = Constants.cellHeight
      rootView.tableView.rowHeight = UITableView.automaticDimension
    
  }

  private func setupUI() {
      view.backgroundColor = UIColor(named: "backgroundCream")
  }

  func showError(_ error: String) {
      print("Error: \(error)")
  }
  
  func displayRecipes(_ recipes: [Recipe]) {
      self.recipes = recipes
      self.rootView.tableView.reloadData()
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
      cell.configure(with: recipe, loadImage: presenter.loadImageForRecipe)
      
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
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      tableView.deselectRow(at: indexPath, animated: true)
  }
}
