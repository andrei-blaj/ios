//
//  CreatePostVC.swift
//  breakPoint
//
//  Created by Andrei-Sorin Blaj on 01/09/2017.
//  Copyright © 2017 Andrei-Sorin Blaj. All rights reserved.
//

import UIKit
import Firebase

class CreatePostVC: UIViewController {

    // Outlets
    @IBOutlet weak var userEmailLbl: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var sendBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textView.delegate = self
        sendBtn.bindToKeyboard()
        
    }

    @IBAction func sendBtnPressed(_ sender: Any) {
        
        if textView.text != nil && textView.text != "Insert text here..." && textView.text != "" {
            sendBtn.isEnabled = false
            
            DataService.instance.uploadPost(withMessage: textView.text, forUID: (Auth.auth().currentUser?.uid)!, withGroupKey: nil, sendComplete: { (isComplete) in
                self.sendBtn.isEnabled = true
                
                if isComplete {
                    self.dismiss(animated: true, completion: nil)
                } else {
                    print("Could not upload!")
                }
            })
            
        }
        
    }
    
    @IBAction func closeBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

extension CreatePostVC: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.text = ""
    }
    
}
