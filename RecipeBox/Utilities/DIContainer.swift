//
//  DIContainer.swift
//  RecipeBox
//
//  Created by Елена Русских on 2023-10-16.
//

import Swinject
import UIKit

let appContainer = Container()

func setupDependencies() {
    setupServices()
    setupMainModule()
}

private func setupServices() {
    appContainer.register(ImageServiceProtocol.self) { _ in KingfisherImageService() }
    appContainer.register(RecipeServiceProtocol.self) { _ in FirestoreService() }
}

private func setupMainModule() {
    appContainer.register(MainViewRouterProtocol.self) { _ in
        let router = MainViewRouter()
        return router
    }

    appContainer.register(MainViewProtocol.self) { _ in
        let controller = MainViewController()
        return controller
    }.inObjectScope(.container)

    appContainer.register(MainViewPresenter.self) { resolver in
        guard let view = resolver.resolve(MainViewProtocol.self),
              let firestoreService = resolver.resolve(RecipeServiceProtocol.self),
              let imageService = resolver.resolve(ImageServiceProtocol.self) else {
                  fatalError("Unable to resolve dependencies for MainViewPresenter.")
              }

        return MainViewPresenter(view: view, firestoreService: firestoreService, imageService: imageService)
    }
  
    if let controller = appContainer.resolve(MainViewProtocol.self) as? MainViewController,
       let router = appContainer.resolve(MainViewRouterProtocol.self) as? MainViewRouter {
        controller.router = router
        router.controller = controller
    }
}
