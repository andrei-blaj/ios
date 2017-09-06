//
//  CameraVC.swift
//  Vision-App
//
//  Created by Andrei-Sorin Blaj on 06/09/2017.
//  Copyright © 2017 Andrei-Sorin Blaj. All rights reserved.
//

import UIKit
import AVFoundation
import CoreML
import Vision

enum FlashState {
    case off
    case on
}

class CameraVC: UIViewController {

    // Variables
    var captureSession: AVCaptureSession!
    var cameraOutput: AVCapturePhotoOutput!
    var previewLayer: AVCaptureVideoPreviewLayer!
    
    var photoData: Data?
    
    var flashControlState: FlashState = .off
    
    var speechSynthesizer = AVSpeechSynthesizer()
    
    // Outlets
    @IBOutlet weak var roundedView: RoundedShadowView!
    @IBOutlet weak var captureImageView: RoundedShadowImageView!
    @IBOutlet weak var flashBtn: RoundedShadowButton!
    @IBOutlet weak var identificationLbl: UILabel!
    @IBOutlet weak var confidenceLbl: UILabel!
    @IBOutlet weak var cameraView: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func flashBtnPressed(_ sender: Any) {
        switch flashControlState {
        case .off:
            flashBtn.setTitle("FLASH ON", for: .normal)
            flashControlState = .on
        case .on:
            flashBtn.setTitle("FLASH OFF", for: .normal)
            flashControlState = .off
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        previewLayer.frame = cameraView.bounds
        speechSynthesizer.delegate = self
    
        activityIndicator.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapCameraView))
        tap.numberOfTapsRequired = 1
        
        captureSession = AVCaptureSession()
        captureSession.sessionPreset = AVCaptureSession.Preset.hd1920x1080
        
        let backCamera = AVCaptureDevice.default(for: AVMediaType.video)
        
        do {
            
            let input = try AVCaptureDeviceInput(device: backCamera!)
            
            if captureSession.canAddInput(input) == true {
                captureSession.addInput(input)
            }
            
            cameraOutput = AVCapturePhotoOutput()
            
            if captureSession.canAddOutput(cameraOutput) == true {
                captureSession.addOutput(cameraOutput!)
                
                previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
                previewLayer.videoGravity = AVLayerVideoGravity.resizeAspect
                previewLayer.connection?.videoOrientation = AVCaptureVideoOrientation.portrait
                
                cameraView.layer.addSublayer(previewLayer!)
                cameraView.addGestureRecognizer(tap)
                captureSession.startRunning()
                
            }
            
        } catch {
            debugPrint(error)
        }
        
    }
    
    @objc func didTapCameraView() {
        self.cameraView.isUserInteractionEnabled = false
        self.activityIndicator.isHidden = false
        self.activityIndicator.startAnimating()
        
        let settings = AVCapturePhotoSettings()
        
        let previewPixelType = settings.availablePreviewPhotoPixelFormatTypes.first!
        let previewFormat = [kCVPixelBufferPixelFormatTypeKey as String: previewPixelType, kCVPixelBufferWidthKey as String: 160, kCVPixelBufferHeightKey as String: 160]
        
        if flashControlState == .off {
            settings.flashMode = .off
        } else {
            settings.flashMode = .on
        }
        
        settings.previewPhotoFormat = previewFormat
        
        cameraOutput.capturePhoto(with: settings, delegate: self)
        
    }
    
    func resultsMethod(request: VNRequest, error: Error?) {
        guard let results = request.results as? [VNClassificationObservation] else { return }
    
        for classification in results {
            if classification.confidence < 0.5 {
                
                let unknownObjectMessage = "I'm not sure what this is, please try again"
                
                synthesizeSpeech(fromString: unknownObjectMessage)
                self.identificationLbl.text = unknownObjectMessage
                self.confidenceLbl.text = ""
                
                break
                
            } else {
                
                let identification = classification.identifier
                let confidence = Int(classification.confidence * 100)
                
                self.identificationLbl.text = identification
                self.confidenceLbl.text = "CONFIDENCE: \(confidence)%"
                
                let completeSentence = "I'm \(confidence) percent sure this is a \(identification)."
                synthesizeSpeech(fromString: completeSentence)
                
                break
                
            }
        }
    
    }
    
    func synthesizeSpeech(fromString string: String) {
        let speechUtterance = AVSpeechUtterance(string: string)
        speechSynthesizer.speak(speechUtterance)
    }
    
}

extension CameraVC: AVCapturePhotoCaptureDelegate {
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        if let error = error {
            debugPrint(error)
        } else {
            photoData = photo.fileDataRepresentation()
            
            do {
                let model = try VNCoreMLModel(for: SqueezeNet().model)
                let request = VNCoreMLRequest(model: model, completionHandler: resultsMethod)
                let handler = VNImageRequestHandler(data: photoData!)
                
                try handler.perform([request])
                
            } catch {
                // Handle errors
                debugPrint(error)
            }
            
            let image = UIImage(data: photoData!)
            self.captureImageView.image = image
        }
    }
}

extension CameraVC: AVSpeechSynthesizerDelegate {
    
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        // Code to finish utterance
        self.cameraView.isUserInteractionEnabled = true
        self.activityIndicator.isHidden = true
        self.activityIndicator.stopAnimating()
    }
    
}

