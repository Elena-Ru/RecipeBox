//
//  DetailViewController.swift
//  RecipeBox
//
//  Created by Елена Русских on 2023-10-16.
//

import Foundation
import UIKit

protocol RecipeDetailViewControllerProtocol { }

final class DetailViewController: UIViewController, RecipeDetailViewControllerProtocol {
    var recipe: Recipe?
  
  init(recipe: Recipe? = nil) {
      self.recipe = recipe
      super.init(nibName: nil, bundle: nil)
   }
  
  required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
      super.viewDidLoad()
    
      view.backgroundColor = Asset.backgroundCream.color
      title = recipe?.title.capitalized
      navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: Asset.darkGreenText.color]
      navigationController?.navigationBar.tintColor = Asset.darkGreenText.color
  }
}
