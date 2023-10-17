//
//  MainViewRouter.swift
//  RecipeBox
//
//  Created by Елена Русских on 2023-10-11.
//

import UIKit

protocol MainViewRouterProtocol {
    func toAddNewRecipe()
    func toRecipeDetail(recipe: Recipe)
}

final class MainViewRouter: Router, MainViewRouterProtocol {
    
  func toAddNewRecipe(){
    //create vc
    //show(vc)
  }
  
  func toRecipeDetail(recipe: Recipe ) {
      let recipeDetailVC = DetailViewController(recipe: recipe, imageService: KingfisherImageService())
      show(recipeDetailVC)
  }
}
