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
    
    @IBOutlet weak var uploadBtn: UIButton!
    
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
    
    func addText() {
        
        if let device = theMiniBusText {
            let string = "\(device.texteng!)\n\(device.textzhone!)\n\(device.textzhtwo!)"
            let text = SCNText(string: string, extrusionDepth: 0.1)
            text.font = UIFont.systemFont(ofSize: 1)
            text.flatness = 0.005
            let textNode = SCNNode(geometry: text)
            let fontScale: Float = 0.01
            textNode.scale = SCNVector3(fontScale, 0.01, -0.01)
            
            let (min, max) = (text.boundingBox.min, text.boundingBox.max)
            let dx = min.x + 0.5 * (max.x - min.x)
            let dy = min.y + 0.5 * (max.y - min.y)
            let dz = min.z + 0.5 * (max.z - min.z)
            textNode.pivot = SCNMatrix4MakeTranslation(dx, dy, dz)
            
            
            let width = (max.x - min.x) * fontScale
            let height = (max.y - min.y) * fontScale
            let padding:Float = 0.01
            let plane = SCNPlane(width: CGFloat(width+padding), height: CGFloat(height+padding))
            let planeNode = SCNNode(geometry: plane)
            
            planeNode.geometry?.firstMaterial?.diffuse.contents = UIColor.black
            planeNode.geometry?.firstMaterial?.isDoubleSided = true
            planeNode.position = SCNVector3(0, -0.1, -0.2)
            textNode.eulerAngles = planeNode.eulerAngles
            planeNode.addChildNode(textNode)
            
            sceneView.scene.rootNode.addChildNode(planeNode)
        
        
        }
    }
    
    @IBAction func uploadBtnClicked(_ sender :Any){
        
        
        if let device = theMiniBusText {
            let engText = device.texteng!;
            let zhOne = device.textzhone!;
            let zhTwo = device.textzhtwo!;
            
            let urlStr = "http://192.168.0.137/cwapi.php"
            
            if let url = URL(string: urlStr) {
                var urlRequest = URLRequest(url: url)
                urlRequest.httpMethod = "POST"
                let body = "engtext=\(engText)&zhone=\(zhOne)&zhtwo=\(zhTwo)"
                if let data  = body.data(using: .utf8) {
                    let dataTask = URLSession.shared.uploadTask(with: urlRequest,
                                                                from: data, completionHandler: {
                        data, response, error in
                        if let error = error{
                            print("error: \(error.localizedDescription)")
                        }
    //                    self.refreshBtnClicked(self)
                    })
                    dataTask.resume()
                }
            }
        }
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
