//
//  DetailViewController.swift
//  RecipeBox
//
//  Created by Елена Русских on 2023-10-16.
//

import Foundation

import UIKit

protocol RecipeDetailViewControllerProtocol {
  
}
final class DetailViewController: UIViewController, RecipeDetailViewControllerProtocol {
  
  override func viewDidLoad() {
     view.backgroundColor = Asset.activeGreen.color
  }
}
