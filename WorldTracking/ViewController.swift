//
//  ViewController.swift
//  WorldTracking
//
//  Created by 山田卓 on 2017/09/19.
//  Copyright © 2017 TakuYamada. All rights reserved.
//

import UIKit
import ARKit

class ViewController: UIViewController {
    
    @IBOutlet weak var sceneView: ARSCNView!
    let configration = ARWorldTrackingConfiguration()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints, ARSCNDebugOptions.showWorldOrigin]
        self.sceneView.session.run(configration)
        self.sceneView.autoenablesDefaultLighting = true
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func addButton(_ sender: UIButton) {
                
        let node = SCNNode()

        // Box Node
        node.geometry = SCNBox(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 0.05)
        let x = randomNumbers(firstNum: -0.3, secondNum: 0.3)
        let y = randomNumbers(firstNum: -0.3, secondNum: 0.3)
        let z = randomNumbers(firstNum: -0.3, secondNum: 0.3)


        node.geometry?.firstMaterial?.specular.contents = UIColor.yellow
        node.geometry?.firstMaterial?.diffuse.contents = UIColor.black
        node.position = SCNVector3(x,y,z)
        
        self.sceneView.scene.rootNode.addChildNode(node)

    }
    
    @IBAction func resetButton(_ sender: UIButton) {
        resetSession()
    }
    
    func resetSession(){
        self.sceneView.session.pause()
        self.sceneView.scene.rootNode.enumerateChildNodes {(node, _) in
            node.removeFromParentNode()
        }
        
        self.sceneView.session.run(configration, options: [.resetTracking, .removeExistingAnchors])
    }
    
    func randomNumbers(firstNum: CGFloat, secondNum: CGFloat) -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UINT32_MAX) * abs(firstNum - secondNum) + min(firstNum, secondNum)
    }
}

