//
//  Ramp.swift
//  Ramp-Up
//
//  Created by Andrei-Sorin Blaj on 07/09/2017.
//  Copyright © 2017 Andrei-Sorin Blaj. All rights reserved.
//

import SceneKit
import UIKit

class Ramp {
    
    class func getRampForName(_ rampName: String) -> SCNNode {
        switch rampName {
        case "pipe":
            return Ramp.getPipe()
        case "quarter":
            return Ramp.getQuarter()
        case "pyramid":
            return Ramp.getPyramid()
        default:
            return Ramp.getPipe()
        }
    }
    
    class func getPipe() -> SCNNode {
        
        // created the pipe scene as an object
        let pipeObj = SCNScene(named: "art.scnassets/pipe.scn")
        let pipeNode = pipeObj?.rootNode.childNode(withName: "pipe", recursively: true)
        
        // scaled the object so it would fit in the popover
        pipeNode?.scale = SCNVector3Make(0.0022, 0.0022, 0.0022)
        pipeNode?.position = SCNVector3Make(-0.95, 0.7, -1)
        
        // added the object to the popover
        return pipeNode!
        
    }
    
    class func getPyramid() -> SCNNode {
    
        let pyramidObj = SCNScene(named: "art.scnassets/pyramid.scn")
        let pyramidNode = pyramidObj?.rootNode.childNode(withName: "pyramid", recursively: true)
        
        pyramidNode?.scale = SCNVector3Make(0.0058, 0.0058, 0.0058)
        pyramidNode?.position = SCNVector3Make(-0.95, -0.35, -1)
        
        return pyramidNode!
    
    }
    
    class func getQuarter() -> SCNNode {
        
        let quarterObj = SCNScene(named: "art.scnassets/quarter.scn")
        let quarterNode = quarterObj?.rootNode.childNode(withName: "quarter", recursively: true)
        
        quarterNode?.scale = SCNVector3Make(0.0058, 0.0058, 0.0058)
        quarterNode?.position = SCNVector3Make(-0.9, -2.1, -1)
        
        return quarterNode!
        
    }
    
    class func startRotation(node: SCNNode) {
        
        let rotate = SCNAction.repeatForever(SCNAction.rotateBy(x: 0, y: CGFloat(0.01 * Double.pi), z: 0, duration: 0.15))
        
        node.runAction(rotate)
        
    }
    
}
