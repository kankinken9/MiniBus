//
//  SignsViewController.swift
//  MiniBus
//
//  Created by kenkan on 15/1/2022.
//

import UIKit
import CoreData

class SignsViewController: UIViewController {

    var theMiniBusText : MiniBusText?
    
    @IBOutlet weak var engLB: UILabel!
    @IBOutlet weak var zhOenLB: UILabel!
    @IBOutlet weak var zhTwoLB: UILabel!
    
    var managedObjectContext : NSManagedObjectContext? {
        if let delegate = UIApplication.shared.delegate as? AppDelegate {
            return delegate.persistentContainer.viewContext;
        }
        return nil;
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //for edit
        if let device = theMiniBusText {
            self.engLB.text = device.texteng!
            self.zhOenLB.text = device.textzhone!
            self.zhTwoLB.text = device.textzhtwo!
        } }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
