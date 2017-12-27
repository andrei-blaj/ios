//
//  UIStoryBoardSegueFromRight.swift
//  Co. Administrator
//
//  Created by Andrei-Sorin Blaj on 26/12/2017.
//  Copyright © 2017 Andrei-Sorin Blaj. All rights reserved.
//

import UIKit

class UIStoryBoardSegueFromRight: UIStoryboardSegue {

    override func perform() {
        let fromViewController = self.source
        let toViewController = self.destination
        
        print("performing")
        
        fromViewController.view.superview?.insertSubview(toViewController.view, aboveSubview: fromViewController.view)
        toViewController.view.transform = CGAffineTransform(translationX: fromViewController.view.frame.size.width, y: 0)
        
        UIView.animate(withDuration: 0.3, delay: 0.0, options: UIViewAnimationOptions.curveEaseInOut, animations: {
            toViewController.view.transform = CGAffineTransform(translationX: 0, y: 0)
        }) { (finished) in
            fromViewController.present(toViewController, animated: false, completion: nil)
        }
    }
    
}

class UIStoryBoardUnwindSegueFromRight: UIStoryboardSegue {
    
    override func perform() {
        let fromViewController = self.source
        let toViewController = self.destination
        
        toViewController.view.superview?.insertSubview(toViewController.view, belowSubview: fromViewController.view)
        fromViewController.view.transform = CGAffineTransform(translationX: 0, y: 0)
        
//        fromViewController.view.superview?.insertSubview(toViewController.view, belowSubview: fromViewController.view)
//        fromViewController.view.transform = CGAffineTransform(translationX: 0, y: 0)
        
        UIView.animate(withDuration: 0.3, delay: 0.0, options: UIViewAnimationOptions.curveEaseInOut, animations: {
            fromViewController.view.transform = CGAffineTransform(translationX: fromViewController.view.frame.size.width, y: 0)
        }) { (finished) in
            fromViewController.dismiss(animated: false, completion: nil)
        }
    }
    
}
