//
//  FirestoreService.swift
//  RecipeBox
//
//  Created by Елена Русских on 2023-10-08.
//

import Firebase
import FirebaseFirestore

protocol RecipeServiceProtocol {
    func loadRecipes(completion: @escaping ([Recipe]?, Error?) -> Void)
}


class FirestoreService: RecipeServiceProtocol {
    
    private let db = Firestore.firestore()
    
    func loadRecipes(completion: @escaping ([Recipe]?, Error?) -> Void) {
        db.collection("recipes").getDocuments { (snapshot, error) in
            if let error = error {
                completion(nil, error)
            } else {
                let recipes = snapshot?.documents.map { (document) -> Recipe in
                    let data = document.data()
                    let id = document.documentID
                    let title = data["title"] as? String ?? ""
                    return Recipe(id: id, title: title)
                }
                completion(recipes, nil)
            }
        }
    }
}

