//
//  MainViewBuilder.swift
//  RecipeBox
//
//  Created by Елена Русских on 2023-10-11.
//

import UIKit

class MainViewBuilder: Builder {
    
    func build() -> UIViewController {
        let view = MainViewController()
        let firestoreService: RecipeServiceProtocol = FirestoreService()
        let imageService: ImageServiceProtocol = KingfisherImageService()
        let presenter = MainViewPresenter(view: view, firestoreService: firestoreService, imageService: imageService)
        
        view.presenter = presenter
        
        return view
    }
}
