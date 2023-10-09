//
//  AnimatedLoaderView.swift
//  RecipeBox
//
//  Created by Елена Русских on 2023-10-09.
//

import Foundation
import UIKit

final class AnimatedLoaderView: UIView {

    private struct Constants {
        static let initialCircleFrame = CGRect(x: 20, y: 20, width: 60, height: 60)
        static let initialCircle2Frame = CGRect(x: 120, y: 20, width: 60, height: 60)
        static let circle1Color = "activeGreen"
        static let circle2Color = "accentOrange"
        static let circleAlpha: CGFloat = 0.9
        static let animationDuration: TimeInterval = 0.4
    }

    let circle1 = UIView(frame: Constants.initialCircleFrame)
    let circle2 = UIView(frame: Constants.initialCircle2Frame)

    let positions: [CGRect] = [
        CGRect(x: 30, y: 20, width: 60, height: 60),
        CGRect(x: 60, y: 15, width: 70, height: 70),
        CGRect(x: 110, y: 20, width: 60, height: 60),
        CGRect(x: 60, y: 25, width: 50, height: 50)
    ]

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false

        configureCircle(
            circle: circle1,
            color: Constants.circle1Color,
            zPosition: 2
        )
        configureCircle(
            circle: circle2,
            color: Constants.circle2Color,
            zPosition: 1
        )
        
        addSubview(circle1)
        addSubview(circle2)
    }

    private func configureCircle(circle: UIView, color: String, zPosition: CGFloat) {
      circle.backgroundColor = UIColor(named: color)?.withAlphaComponent(Constants.circleAlpha)
        circle.layer.cornerRadius = circle.frame.width / 2
        circle.layer.zPosition = zPosition
    }

    func animate(_ circle: UIView, counter: Int) {
        var updatedCounter = counter

        UIView.animate(
            withDuration: Constants.animationDuration,
            delay: .zero,
            options: .curveLinear,
            animations: {
                circle.frame = self.positions[updatedCounter]
                circle.layer.cornerRadius = circle.frame.width / 2
                self.updateZPosition(for: circle, at: updatedCounter)
            }
        ) { (completed) in
            switch updatedCounter {
            case 0...2:
                updatedCounter += 1
            default:
                updatedCounter = 0
            }
            self.animate(circle, counter: updatedCounter)
        }
    }

    private func updateZPosition(for circle: UIView, at counter: Int) {
        switch counter {
        case 1:
            if circle == circle1 {
                circle1.layer.zPosition = 2
            }
        case 3:
            if circle == circle1 {
                circle1.layer.zPosition = 0
            }
        default:
            break
        }
    }
}
