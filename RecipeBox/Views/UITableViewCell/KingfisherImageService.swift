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
        if let url = URL(string: urlString) {
            KingfisherManager.shared.retrieveImage(with: url) { result in
                switch result {
                case .success(let value):
                    completion(value.image)
                case .failure:
                    completion(nil)
                }
            }
        } else {
            completion(nil)
        }
    }
}
