//
//  DashBoardViewController.swift
//  FireBaseDataBase
//
//  Created by Dhruvin Shiyani on 24/09/19.
//  Copyright © 2019 Dhruvin Shiyani. All rights reserved.
//

import UIKit
import FireBaseDataBase
import FirebaseAuth
import Firebase
 
class DashBoardViewController: UIViewController , UITableViewDelegate , UITableViewDataSource {
    
    
    //var user: FIRuser!
    var user: User!
    var items = [Item]()
    var ref: DatabaseReference!
    private var databaseHandle: DatabaseHandle!
    
    
    @IBOutlet weak var tblItem: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.setHidesBackButton(true, animated: true)
        // Do any additional setup after loading the view.
        tblItem.delegate = self
        tblItem.dataSource = self
    }
    
    
    @IBAction func btnActionSignOut(_ sender: Any) {
        
        do {
            try Auth.auth().signOut()
            
            self.navigationController?.popViewController(animated: true)
        } catch let error {
            assertionFailure("Error Signing Out: \(error)")
        }
        
    }
    
    @IBAction func btnActionAddItem(_ sender: Any) {
        
        let prompt = UIAlertController(title: "To Do App", message: "To Do Item", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
            let userInput = prompt.textFields![0].text
            if (userInput!.isEmpty) {
                return
            }
            self.ref.child("users").child(self.user.uid).child("items").childByAutoId().child("title").setValue(userInput)
        }
        prompt.addTextField(configurationHandler: nil)
        prompt.addAction(okAction)
        present(prompt,animated: true, completion: nil);
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemTableViewCell") as! ItemTableViewCell
        let item = items[indexPath.row]
        cell.lblItemCell?.text = item.title
        return cell
    }
    
    func StartObsevingDatabase () {
        databaseHandle = ref.child("users/\(self.user.uid)/items").observe(.value, with: {
            (sanpshot) in
            var newItems = [Item]()
            
            for itemSanpShot in sanpshot.children {
                let itme = Item(snapshot: itemSanpShot as! DataSnapshot)
                newItems.append(itme)
            }
            
            self.items = newItems
            self.tblItem.reloadData()
        })
    }
    
    deinit {
        ref.child("users/\(self.user.uid)/items").removeObserver(withHandle: databaseHandle)
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
