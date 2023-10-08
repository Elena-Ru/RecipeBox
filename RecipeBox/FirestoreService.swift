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
    func addIngredientsToRecipes()
    func updateRecipesWithImageURLs(recipeImageURLs: [String: String], completion: @escaping (Error?) -> ())
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
                    let photo = data["imageURL"] as? String ?? ""
                    return Recipe(id: id, title: title, photo: photo)
                }
                completion(recipes, nil)
            }
        }
    }
  
  func addIngredientsToRecipes() {
          let recipesCollection = db.collection("recipes")

          let mojitoIngredients = [
              ["name": "White rum", "amount": "50 ml"],
              ["name": "Lime juice", "amount": "30 ml"],
              ["name": "Sugar", "amount": "2 tsp"],
              ["name": "Mint", "amount": "10-12 leaves"],
              ["name": "Soda water", "amount": "to taste"],
              ["name": "Ice", "amount": "to taste"]
          ]
          
          let teaIngredients = [
              ["name": "Black or green tea", "amount": "1 bag or 1 tsp"],
              ["name": "Water", "amount": "200-250 ml"],
              ["name": "Sugar or honey", "amount": "to taste"],
              ["name": "Lemon", "amount": "1 slice (optional)"]
          ]
          
          let hurricaneIngredients = [
              ["name": "White rum", "amount": "50 ml"],
              ["name": "Dark rum", "amount": "50 ml"],
              ["name": "Orange juice", "amount": "50 ml"],
              ["name": "Lime juice", "amount": "25 ml"],
              ["name": "Grenadine", "amount": "10 ml"],
              ["name": "Passion fruit juice", "amount": "10 ml"],
              ["name": "Ice", "amount": "to taste"]
          ]

          recipesCollection.whereField("title", isEqualTo: "Mojito").getDocuments { (snapshot, error) in
              guard let document = snapshot?.documents.first else { return }
              document.reference.updateData(["ingredients": mojitoIngredients])
          }

          recipesCollection.whereField("title", isEqualTo: "Tea").getDocuments { (snapshot, error) in
              guard let document = snapshot?.documents.first else { return }
              document.reference.updateData(["ingredients": teaIngredients])
          }

          recipesCollection.whereField("title", isEqualTo: "Hurricane cocktail").getDocuments { (snapshot, error) in
              guard let document = snapshot?.documents.first else { return }
              document.reference.updateData(["ingredients": hurricaneIngredients])
          }
      }
  
  func updateRecipesWithImageURLs(recipeImageURLs: [String: String], completion: @escaping (Error?) -> ()) {
      
      for (recipeTitle, imageURL) in recipeImageURLs {
          
          db.collection("recipes").whereField("title", isEqualTo: recipeTitle).getDocuments { (snapshot, error) in
              
              guard let documents = snapshot?.documents else {
                  completion(error)
                  return
              }
              
              for document in documents {
                  document.reference.updateData([
                      "imageURL": imageURL
                  ])
              }
          }
      }
      
      completion(nil)
  }
}

