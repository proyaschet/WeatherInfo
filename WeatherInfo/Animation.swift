//
//  Animation.swift
//  WeatherInfo
//
//  Created by Amarnath Manipatra on 25/07/17.
//  Copyright © 2017 otd. All rights reserved.
//

import UIKit
import Foundation
protocol AnimationView {
    static func hide(view: UIView, alpha: Int)
}

final class Animations: AnimationView {
    static func hide(view: UIView, alpha: Int) {
        //let duration = Animation.Duration.medium
        UIView.animate(withDuration: TimeInterval(0.0),
                       delay: TimeInterval(0),
                       options: [UIViewAnimationOptions.allowUserInteraction, UIViewAnimationOptions.beginFromCurrentState],
                       animations: {
                        view.alpha = CGFloat(alpha)
        }, completion: { (_) in
            view.removeFromSuperview()
        })
    }
}
