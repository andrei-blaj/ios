//
//  PopVC.swift
//  PixelCity
//
//  Created by Andrei-Sorin Blaj on 22/08/2017.
//  Copyright © 2017 Andrei-Sorin Blaj. All rights reserved.
//

import UIKit

class PopVC: UIViewController, UIGestureRecognizerDelegate {

    // Outlets
    @IBOutlet weak var popImageView: UIImageView!
    
    // Variables
    var passedImage: UIImage!
    
    func initData(forImage image: UIImage) {
        self.passedImage = image
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        popImageView.image = passedImage
        addSwipeDown()
    }

    func addSwipeDown() {
        let swipe = UISwipeGestureRecognizer(target: self, action: #selector(screenWasSwipedDown))
        swipe.direction = .down
        
        view.addGestureRecognizer(swipe)
    }

    @objc func screenWasSwipedDown() {
        dismiss(animated: true, completion: nil)
    }
    
//    func addDoubleTap() {
//        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(screenWasDoubleTapped))
//
//        doubleTap.numberOfTapsRequired = 2
//        doubleTap.delegate = self
//
//        view.addGestureRecognizer(doubleTap)
//    }
//
//    @objc func screenWasDoubleTapped() {
//        dismiss(animated: true, completion: nil)
//    }
    
}
