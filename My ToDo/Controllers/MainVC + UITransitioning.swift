//
//  MainVC + UITransitioning.swift
//  My ToDo
//
//  Created by Максим on 20.04.2022.
//

import UIKit

extension MainVC: UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        transition.transitionMode = .present
        transition.startingPoint = newTaskButton.center
        
        //цвет пузыря
        transition.bubbleColor = presented.view.backgroundColor ?? UIColor.white
        return transition
    }
    
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        transition.transitionMode = .dismiss
        transition.startingPoint = newTaskButton.center
        
        //цвет пузыря
        transition.bubbleColor = dismissed.view.backgroundColor ?? UIColor.white
        return transition
    }
}
