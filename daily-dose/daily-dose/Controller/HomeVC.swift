//
//  ViewController.swift
//  daily-dose
//
//  Created by Andrei-Sorin Blaj on 08/09/2017.
//  Copyright © 2017 Andrei-Sorin Blaj. All rights reserved.
//

import UIKit
import GoogleMobileAds

class HomeVC: UIViewController {

    // Outlets
    @IBOutlet weak var bannerView: GADBannerView!
    @IBOutlet weak var removeAdsBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupAds()
        
        
    }

    func setupAds() {
        if UserDefaults.standard.bool(forKey: PurchaseManager.instance.IAP_REMOVE_ADS) {
            removeAdsBtn.removeFromSuperview()
            bannerView.removeFromSuperview()
        } else {
            bannerView.adUnitID = "ca-app-pub-3940256099942544/2934735716"
            bannerView.rootViewController = self
            bannerView.load(GADRequest())
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onRestoreBtnPressed(_ sender: Any) {
        PurchaseManager.instance.restorePurchases { (success) in
            if success {
                self.setupAds()
            }
        }
    }
    
    @IBAction func onRemoveAdsPressed(_ sender: Any) {
        // show a loading spinner
        PurchaseManager.instance.purchaseRemoveAds { (success) in
            // dismiss the spinner
            if success {
                self.bannerView.removeFromSuperview()
                self.removeAdsBtn.removeFromSuperview()
            } else {
                // in case of failure
                // show a message to the user
            }
        }
    }
    
}

