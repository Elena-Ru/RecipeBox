//
//  AnimatedLaunchScreen.swift
//  RecipeBox
//
//  Created by Елена Русских on 2023-10-09.
//

import UIKit
import SnapKit

final class AnimatedLaunchScreen: UIViewController {
    
    // MARK: - Constants
    private enum Constants {
        static let rotatingCirclesWidth: CGFloat = 200
        static let rotatingCirclesHeight: CGFloat = 100
        static let circle1Counter = 1
        static let circle2Counter = 3
    }
  
    let rotatingCicrlesView = AnimatedLoaderView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Asset.backgroundCream.color
        configureRotatingCircles()
        rotatingCicrlesView.animate(rotatingCicrlesView.circle1, counter: Constants.circle1Counter)
        rotatingCicrlesView.animate(rotatingCicrlesView.circle2, counter: Constants.circle2Counter)
    }
  
    private func configureRotatingCircles() {
        view.addSubview(rotatingCicrlesView)
      
        rotatingCicrlesView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(Constants.rotatingCirclesWidth)
            make.height.equalTo(Constants.rotatingCirclesHeight)
        }
    }
}
