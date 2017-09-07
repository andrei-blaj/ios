//
//  RampPickerVC.swift
//  Ramp-Up
//
//  Created by Andrei-Sorin Blaj on 07/09/2017.
//  Copyright © 2017 Andrei-Sorin Blaj. All rights reserved.
//

import UIKit
import SceneKit

class RampPickerVC: UIViewController {

    var sceneView: SCNView!
    var size: CGSize!
    weak var rampPlacerVC: RampPlacerVC!
    
    init(size: CGSize) {
        super.init(nibName: nil, bundle: nil)
        self.size = size
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.frame = CGRect(origin: CGPoint.zero, size: size)
        sceneView = SCNView(frame: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        view.insertSubview(sceneView, at: 0)
        
        preferredContentSize = size
        
        let scene = SCNScene(named: "art.scnassets/textures/ramps.scn")!
        sceneView.scene = scene
        
        // The camera view of the popover would ignore the z axis
        let camera = SCNCamera()
        camera.usesOrthographicProjection = true
        scene.rootNode.camera = camera
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        sceneView.addGestureRecognizer(tap)
        
        let rotatePipe = SCNAction.repeatForever(SCNAction.rotateBy(x: 0, y: CGFloat(0.01 * Double.pi), z: 0, duration: 0.15))
        let rotatePyramid = SCNAction.repeatForever(SCNAction.rotateBy(x: 0, y: CGFloat(0.01 * Double.pi), z: 0, duration: 0.1))
        let rotateQuarter = SCNAction.repeatForever(SCNAction.rotateBy(x: 0, y: CGFloat(0.01 * Double.pi), z: 0, duration: 0.2))
        
        // created the pipe scene as an object
        let pipeObj = SCNScene(named: "art.scnassets/pipe.scn")
        let pipeNode = pipeObj?.rootNode.childNode(withName: "pipe", recursively: true)
        
        pipeNode?.runAction(rotatePipe)
        
        // scaled the object so it would fit in the popover
        pipeNode?.scale = SCNVector3Make(0.0022, 0.0022, 0.0022)
        pipeNode?.position = SCNVector3Make(-0.95, 0.7, -1)
        
        // added the object to the popover
        scene.rootNode.addChildNode(pipeNode!)
        
        let pyramidObj = SCNScene(named: "art.scnassets/pyramid.scn")
        let pyramidNode = pyramidObj?.rootNode.childNode(withName: "pyramid", recursively: true)
        
        pyramidNode?.runAction(rotatePyramid)
        
        pyramidNode?.scale = SCNVector3Make(0.0058, 0.0058, 0.0058)
        pyramidNode?.position = SCNVector3Make(-0.95, -0.35, -1)
        
        scene.rootNode.addChildNode(pyramidNode!)
        
        let quarterObj = SCNScene(named: "art.scnassets/quarter.scn")
        let quarterNode = quarterObj?.rootNode.childNode(withName: "quarter", recursively: true)
        
        quarterNode?.runAction(rotateQuarter)
        
        quarterNode?.scale = SCNVector3Make(0.0058, 0.0058, 0.0058)
        quarterNode?.position = SCNVector3Make(-0.9, -2.1, -1)
        
        scene.rootNode.addChildNode(quarterNode!)
        
    }

    @objc func handleTap(_ gestureRecognizer: UIGestureRecognizer) {
        
        let p = gestureRecognizer.location(in: sceneView)
        let hitResults = sceneView.hitTest(p, options: [:])
        
        if hitResults.count > 0 {
            let node = hitResults[0].node
            
            rampPlacerVC.onRampSelected(node.name!)
        }
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
