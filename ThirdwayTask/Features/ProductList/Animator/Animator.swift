//
//  StretchAnimator.swift
//  CustomTransitions
//
//  Created by Ahmed masoud on 3/27/20.
//  Copyright © 2020 Ahmed Masoud. All rights reserved.
//

import UIKit

class FadeAnimation: NSObject, UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)
        if let vc = toViewController {
            transitionContext.finalFrame(for: vc)
            transitionContext.containerView.addSubview(vc.view)
            vc.view.alpha = 0.0
            UIView.animate(withDuration: self.transitionDuration(using: transitionContext),
            animations: {
                vc.view.alpha = 1.0
            },
            completion: { finished in
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            })
        } else {
            print("Oops! Something went wrong! 'ToView' controller is nill")
        }
    }
}

