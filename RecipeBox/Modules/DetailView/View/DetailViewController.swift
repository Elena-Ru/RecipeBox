//
//  DetailViewController.swift
//  RecipeBox
//
//  Created by Елена Русских on 2023-10-16.
//

import Foundation
import UIKit

protocol RecipeDetailViewControllerProtocol { }

final class DetailViewController: UIViewController, RecipeDetailViewControllerProtocol {
    var recipe: Recipe?
    private let imageService: ImageServiceProtocol
    private var collectionView: UICollectionView!
  
    init(recipe: Recipe? = nil, imageService: ImageServiceProtocol) {
        self.recipe = recipe
        self.imageService = imageService
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

  private var dataSource: UICollectionViewDiffableDataSource<Section, Recipe>!

    override func viewDidLoad() {
        super.viewDidLoad()
    
        view.backgroundColor = Asset.backgroundCream.color
        setupCollectionView()
      dataSource = UICollectionViewDiffableDataSource<Section, Recipe>(collectionView: collectionView) { (collectionView, indexPath, recipe) -> UICollectionViewCell? in
          guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecipeImageCell.identifier, for: indexPath) as? RecipeImageCell else {
              return nil
          }
          
          self.imageService.loadImage(from: recipe.photo) { image in
              cell.recipeImageView.image = image
          }
          return cell
      }
        configureDataSource()
    }
  
  // MARK: - UI Setup
   private func setupCollectionView() {
       collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
       collectionView.backgroundColor = .clear
       collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
       collectionView.register(RecipeImageCell.self, forCellWithReuseIdentifier: RecipeImageCell.identifier)
       view.addSubview(collectionView)
   }
   
   private func createLayout() -> UICollectionViewLayout {
       let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(0.5))
       let item = NSCollectionLayoutItem(layoutSize: itemSize)

       let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(0.5))
       let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

       let section = NSCollectionLayoutSection(group: group)
       section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)

       return UICollectionViewCompositionalLayout(section: section)
   }
  
  // MARK: - Data Source
   private func configureDataSource() {
       guard let recipe = recipe else { return }

       let items = [recipe]
       var snapshot = NSDiffableDataSourceSnapshot<Section, Recipe>()
       snapshot.appendSections([.main])
       snapshot.appendItems(items)
       dataSource.apply(snapshot)
   }
}

// MARK: - CollectionView Data Source
extension DetailViewController {
    enum Section {
        case main
    }
}
