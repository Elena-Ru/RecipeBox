//
//  MainViewPresenter.swift
//  RecipeBox
//
//  Created by Елена Русских on 2023-10-09.
//

import Foundation
import UIKit

class MainViewPresenter {
    
    private weak var view: MainViewProtocol?
    private let firestoreService: RecipeServiceProtocol
    private let imageService: ImageServiceProtocol

    init(view: MainViewProtocol, firestoreService: RecipeServiceProtocol, imageService: ImageServiceProtocol) {
        self.view = view
        self.firestoreService = firestoreService
        self.imageService = imageService
    }

    func loadRecipes() {
        firestoreService.loadRecipes { [weak self] (recipes, error) in
            if let error = error {
                self?.view?.showError(error.localizedDescription)
            } else if let recipes = recipes {
                self?.view?.displayRecipes(recipes)
            }
        }
    }

    func loadImageForRecipe(_ recipe: Recipe, completion: @escaping (UIImage?) -> Void) {
        imageService.loadImage(from: recipe.photo, completion: completion)
    }
}
