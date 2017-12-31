//
//  PopVC.swift
//  Co. Administrator
//
//  Created by Andrei-Sorin Blaj on 31/12/2017.
//  Copyright © 2017 Andrei-Sorin Blaj. All rights reserved.
//

import UIKit

class PopVC: UIViewController {

    // Outlets
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var dismissBtn: UIButton!
    
    // Variables
    var passedImage = UIImage()
    
    func initData(forImage image: UIImage) {
        self.passedImage = image
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        imageView.image = passedImage
        dismissBtn.isEnabled = false
        
        addSwipeDown()
    }
    
    @IBAction func onDismissPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        dismissBtn.clipsToBounds = true
        dismissBtn.layer.cornerRadius = 20
    }
    
    func addSwipeDown() {
        let swipe = UISwipeGestureRecognizer(target: self, action: #selector(screenWasSwipedDown))
        swipe.direction = .down
        
        view.addGestureRecognizer(swipe)
    }
    
    @objc func screenWasSwipedDown() {
        self.presentedViewController?.dismiss(animated: true, completion: nil)
        dismiss(animated: true, completion: nil)
    }
}
