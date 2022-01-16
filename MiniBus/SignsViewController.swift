//
//  SignsViewController.swift
//  MiniBus
//
//  Created by kenkan on 15/1/2022.
//

import UIKit
import CoreData
import ARKit

class SignsViewController: UIViewController {
    
    var theMiniBusText : MiniBusText?
    
    @IBOutlet weak var engLB: UILabel!
    @IBOutlet weak var zhOenLB: UILabel!
    @IBOutlet weak var zhTwoLB: UILabel!
    
    @IBOutlet weak var sceneView: ARSCNView!
    
    var managedObjectContext : NSManagedObjectContext? {
        if let delegate = UIApplication.shared.delegate as? AppDelegate {
            return delegate.persistentContainer.viewContext;
        }
        return nil;
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
//        addBox()
        addText()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //for edit
        if let device = theMiniBusText {
            self.engLB.text = device.texteng!
            self.zhOenLB.text = device.textzhone!
            self.zhTwoLB.text = device.textzhtwo!
        }
        
        //AR
        let configuration = ARWorldTrackingConfiguration()
        sceneView.session.run(configuration)
        
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        
        super.viewWillDisappear(animated)
        sceneView.session.pause()
        
    }
    
    
    
    // AR item
//    func addBox() {
//        
//        let box = SCNBox(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 0)
//        
//        let boxNode = SCNNode()
//        boxNode.geometry = box
//        boxNode.position = SCNVector3(0, 0, -0.2)
//        
//        let scene = SCNScene()
//        scene.rootNode.addChildNode(boxNode)
//        sceneView.scene = scene
//        
//    }
    
//    func addBox() {
//
//        let box = SCNBox(width: 0.05, height: 0.05, length: 0.05, chamferRadius: 0)
//
//        let boxNode = SCNNode()
//        boxNode.geometry = box
//        boxNode.position = SCNVector3(0, -0.1, -0.2)
//
//        sceneView.scene.rootNode.addChildNode(boxNode)
//
//    }
    
    func addText() {
        
        let text = SCNText(string: "test", extrusionDepth: 1)
        
//        let boxNode = SCNNode()
//        boxNode.geometry = box
//        boxNode.position = SCNVector3(0, -0.1, -0.2)
//
//        sceneView.scene.rootNode.addChildNode(boxNode)
//
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
