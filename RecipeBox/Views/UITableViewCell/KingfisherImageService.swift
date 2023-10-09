//
//  KingfisherImageService.swift
//  RecipeBox
//
//  Created by Елена Русских on 2023-10-09.
//

import UIKit
import Kingfisher

protocol ImageServiceProtocol {
    func loadImage(from url: String, completion: @escaping (UIImage?) -> Void)
}

final class KingfisherImageService: ImageServiceProtocol {
  func loadImage(from urlString: String, completion: @escaping (UIImage?) -> Void) {
      let placeholderImage = UIImage(named: "dish_placeholder")
         if let url = URL(string: urlString) {
           let resource = KF.ImageResource(downloadURL: url)
             let option: KingfisherOptionsInfo = [.transition(.fade(0.2))]
             KingfisherManager.shared.retrieveImage(with: resource, options: option) { result in
                 switch result {
                 case .success(let value):
                     completion(value.image)
                 case .failure:
                     completion(placeholderImage)
                 }
             }
         } else {
             completion(placeholderImage)
         }
     }
}
