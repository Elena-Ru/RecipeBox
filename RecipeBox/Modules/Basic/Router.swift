//
//  Router.swift
//  RecipeBox
//
//  Created by Елена Русских on 2023-10-11.
//

import UIKit

protocol BaseRouterProtocol: AnyObject {
    func show(_ controller: UIViewController)
    func present(_ controller: UIViewController)
    func setAsRoot(_ controller: UIViewController)
}

class Router: BaseRouterProtocol {
    weak var controller: UIViewController!
    
    func show(_ controller: UIViewController) {
        controller.show(controller, sender: nil)
    }
    
    func present(_ controller: UIViewController) {
        controller.present(controller, animated: true)
    }
    
    func setAsRoot(_ controller: UIViewController) {
        UIApplication.shared.keyWindow?.rootViewController = controller
    }
}
