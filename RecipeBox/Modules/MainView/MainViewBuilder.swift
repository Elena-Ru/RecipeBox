//
//  MainViewBuilder.swift
//  RecipeBox
//
//  Created by Елена Русских on 2023-10-11.
//

import UIKit
import Swinject

final class MainViewBuilder: Builder {
    
    func build() -> UIViewController {
        guard let view = appContainer.resolve(MainViewProtocol.self) as? MainViewController,
              let presenter = appContainer.resolve(MainViewPresenter.self) else {
            fatalError("Error resolving dependencies for MainView")
        }

        view.presenter = presenter
        
        return view
    }
}
