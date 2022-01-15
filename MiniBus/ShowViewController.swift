//
//  ShowViewController.swift
//  MiniBus
//
//  Created by kenkan on 15/1/2022.
//

import UIKit
import CoreData
import RealityKit
import Combine

class ShowViewController: UITableViewController {
    var minibus : [MiniBusText]?;
    
    
    @IBAction func cancel(segue : UIStoryboardSegue){
    }
//    @IBAction func save(segue : UIStoryboardSegue){
//        if let source = segue.source as? AddEditViewController,
//           let context = self.manageObjectContext {
//            if let device = source.theMiniBusText {
//                //for edit
//                device.texteng = source.textengTF.text
//                device.textzhone = source.textzhoneTF.text
//                device.textzhtwo = source.textzhtwoTF.text
//            } else if let newMiniBusText = NSEntityDescription.insertNewObject(forEntityName: "MiniBusText",
//                                                                          into: context) as? MiniBusText {
//                //for new device
//                newMiniBusText.texteng = source.textengTF.text
//                newMiniBusText.textzhone = source.textzhoneTF.text
//                newMiniBusText.textzhtwo = source.textzhtwoTF.text
//            }
//            do {
//                try context.save();
//            } catch  {
//                print("can't save");
//            }
//            self.searchAndReloadTable(query: "")
//        }
//    }
    
    var manageObjectContext : NSManagedObjectContext? {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            return appDelegate.persistentContainer.viewContext
        }
        return nil;
    }
    
    func searchAndReloadTable(query:String){
        if let manageObjectContext = self.manageObjectContext {
            let fetchRequest = NSFetchRequest<MiniBusText>(entityName: "MiniBusText");
            if query.count > 0 {
                let predicate = NSPredicate(format: "name contains[cd] %@", query)
            }
            do {
                let theMiniBusTexts = try manageObjectContext.fetch(fetchRequest)
                self.minibus = theMiniBusTexts
                self.tableView.reloadData()
            } catch {
                
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.searchAndReloadTable(query: "")
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if let minibus = self.minibus {
            return minibus.count
        }
        return 0
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        // Configure the cell...
        if let device = self.minibus?[indexPath.row] {
            cell.textLabel?.text = "\(device.texteng!)"
            cell.detailTextLabel?.text = "\(device.textzhone!) \(device.textzhtwo!)"
            
//                cell.textLabel?.text = "\(device.textzhtwo!)"
        }
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowSignSegue" {
            if let navVC = segue.destination as? UINavigationController {
                if let addEditVC = navVC.topViewController as? SignsViewController {
                    if let indexPath = tableView.indexPathForSelectedRow {
                        if let minibus = self.minibus {
                            addEditVC.theMiniBusText = minibus[indexPath.row]
                        }
                    } }
            } }
    }
    
//    override func tableView(_ tableView: UITableView, commit editingStyle:
//                            UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            if let device  = self.minibus?.remove(at: indexPath.row) {
//                manageObjectContext?.delete(device)
//                try? self.manageObjectContext?.save()
//            }
//            self.tableView.deleteRows(at: [indexPath], with: .fade);
//        }
//    }
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
