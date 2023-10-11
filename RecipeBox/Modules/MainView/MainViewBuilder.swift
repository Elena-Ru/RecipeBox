//
//  MainViewBuilder.swift
//  RecipeBox
//
//  Created by Елена Русских on 2023-10-11.
//

import UIKit

final class MainViewBuilder: Builder {
    
    func build() -> UIViewController {
        let view = MainViewController()
        let router: Router & MainViewRouterProtocol = MainViewRouter()
        let firestoreService: RecipeServiceProtocol = FirestoreService()
        let imageService: ImageServiceProtocol = KingfisherImageService()
        let presenter = MainViewPresenter(view: view, firestoreService: firestoreService, imageService: imageService)
      
        router.controller = view
        view.presenter = presenter
        view.router = router
        
        return view
    }
}
