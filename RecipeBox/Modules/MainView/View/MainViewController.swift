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

    var presenter: MainViewPresenter!
    var router: MainViewRouterProtocol!
    var recipes: [Recipe] = []

    override func loadView() {
        view = rootView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        rootView.addButton.addTarget(self, action: #selector(addRecipe), for: .touchUpInside)
        rootView.tableView.estimatedRowHeight = Constants.cellHeight
        rootView.tableView.rowHeight = UITableView.automaticDimension
        rootView.searchBar.delegate = self

        presenter.loadRecipes()
    }

    @objc func addRecipe(sender: UIButton!) {
        router.toAddNewRecipe()
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
        let backButton = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem = backButton
        router.toRecipeDetail(recipe: recipes[indexPath.section])
    }
}

extension MainViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let query = searchBar.text, !query.trimmingCharacters(in: .whitespaces).isEmpty else {
            return
        }
        presenter.searchRecipes(query: query)
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            presenter.loadRecipes()
        }
    }
}
