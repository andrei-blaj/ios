//
//  CameraVC.swift
//  Vision
//
//  Created by Andrei-Sorin Blaj on 06/09/2017.
//  Copyright © 2017 Andrei-Sorin Blaj. All rights reserved.
//

import UIKit

class CameraVC: UIViewController {

    // Outlets
    @IBOutlet weak var roundedView: RoundedShadowView!
    @IBOutlet weak var captureImageView: RoundedShadowImageView!
    @IBOutlet weak var flashBtn: RoundedShadowButton!
    @IBOutlet weak var identificationLbl: UILabel!
    @IBOutlet weak var confidenceLbl: UILabel!
    @IBOutlet weak var cameraView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}

