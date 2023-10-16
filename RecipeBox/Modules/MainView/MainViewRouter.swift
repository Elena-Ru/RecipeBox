//
//  MainViewRouter.swift
//  RecipeBox
//
//  Created by Елена Русских on 2023-10-11.
//

import UIKit

protocol MainViewRouterProtocol {
    func toAddNewRecipe()
    func toRecipeDetail()
}

final class MainViewRouter: Router, MainViewRouterProtocol {
    
  func toAddNewRecipe(){
    //create vc
    //show(vc)
  }
  
  func toRecipeDetail() {
      let recipeDetailVC = DetailViewController()
      show(recipeDetailVC)
  }
}
