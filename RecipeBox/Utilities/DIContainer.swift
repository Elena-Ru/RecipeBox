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
    setupMVP()
}

private func setupServices() {
    appContainer.register(ImageServiceProtocol.self) { _ in KingfisherImageService() }
    appContainer.register(RecipeServiceProtocol.self) { _ in FirestoreService() }
}

private func setupMVP() {
    appContainer.register(MainViewRouterProtocol.self) { _ in MainViewRouter() }
    .inObjectScope(.container)

    appContainer.register(MainViewProtocol.self) { resolver in
        let controller = MainViewController()

        guard let router = resolver.resolve(MainViewRouterProtocol.self) else {
            fatalError("Unable to resolve MainViewRouterProtocol.")
        }

        controller.router = router
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
}
