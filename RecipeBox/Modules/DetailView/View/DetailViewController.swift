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

    private var dataSource: UICollectionViewDiffableDataSource<Section, RecipeItem>!

    override func viewDidLoad() {
        super.viewDidLoad()
    
        view.backgroundColor = Asset.backgroundCream.color
        setupCollectionView()
        dataSource = UICollectionViewDiffableDataSource<Section, RecipeItem>(collectionView: collectionView) {  (collectionView, indexPath, item) -> UICollectionViewCell? in
            switch item {
            case .image(let recipe):
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecipeImageCell.identifier,  for: indexPath) as? RecipeImageCell else { return nil }
                self.imageService.loadImage(from: recipe.photo) { image in
                    cell.configure(with: image ?? Asset.dishPlaceholder.image)
                }
                return cell
  
            case .title(let recipe):
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecipeTitleCell.identifier,  for: indexPath) as? RecipeTitleCell else { return nil }
                cell.configure(with: recipe)
                return cell
            }
        }
        configureDataSource()
    }
  
    // MARK: - UI Setup
    private func setupCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
        collectionView.backgroundColor = .clear
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.register(RecipeImageCell.self, forCellWithReuseIdentifier: RecipeImageCell.identifier)
        collectionView.register(RecipeTitleCell.self, forCellWithReuseIdentifier: RecipeTitleCell.identifier)
        view.addSubview(collectionView)
    }
   private func createLayout() -> UICollectionViewLayout {
     let layout = UICollectionViewCompositionalLayout { (sectionIndex, environment) -> NSCollectionLayoutSection? in
       guard let section = Section(rawValue: sectionIndex) else { return nil }
       
       switch section {
       case .image:
         let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(0.5))
         let item = NSCollectionLayoutItem(layoutSize: itemSize)
         
         let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(0.5))
         let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
         
         let section = NSCollectionLayoutSection(group: group)
         section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
         return section

       case .title:
         let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(44))
         let item = NSCollectionLayoutItem(layoutSize: itemSize)
         let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(44))
         let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
         let section = NSCollectionLayoutSection(group: group)
         section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
         return section
       }
     }
       return layout
   }
  
    // MARK: - Data Source
  private func configureDataSource() {
      guard let recipe = recipe else { return }
    
      var snapshot = NSDiffableDataSourceSnapshot<Section, RecipeItem>()
      snapshot.appendSections([.image, .title])
      snapshot.appendItems([.image(recipe)], toSection: .image)
      snapshot.appendItems([.title(recipe)], toSection: .title)
      dataSource.apply(snapshot)
  }
}

// MARK: - CollectionView Data Source
extension DetailViewController {
    enum Section: Int, CaseIterable {
        case image
        case title
    }
  
  enum RecipeItem: Hashable {
      case image(Recipe)
      case title(Recipe)
  }

}
