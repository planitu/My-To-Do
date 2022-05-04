//
//  UIButton + Extensions.swift
//  My ToDo
//
//  Created by Максим on 20.04.2022.
//

import UIKit

extension UIView {
    
    func rotate(duration: CFTimeInterval = 1, turns: CGFloat = 1) {
        let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotateAnimation.fromValue = 0.0
        rotateAnimation.toValue = CGFloat(.pi * turns)
        rotateAnimation.duration = duration
        
        self.layer.add(rotateAnimation, forKey: nil)
    }
    
    func shake() {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.duration = 0.5
        animation.values = [-16.0, 16.0, -16.0, 16.0, -8.0, 8.0, -4.0, 4.0, 0.0 ]
        layer.add(animation, forKey: "shake")
    }
}
