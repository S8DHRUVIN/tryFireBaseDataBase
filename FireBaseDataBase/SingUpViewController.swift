//
//  SingUpViewController.swift
//  FireBaseDataBase
//
//  Created by Dhruvin Shiyani on 24/09/19.
//  Copyright © 2019 Dhruvin Shiyani. All rights reserved.
//

import UIKit
import Firebase

class SingUpViewController: UIViewController {
    
    
    
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassWord: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func btnActionRegister(_ sender: Any) {
        
        if validate{
            
            Auth.auth().createUser(withEmail: txtEmail.text!, password: txtPassWord.text!, completion: { (user, error) in
                if let error = error {
                    if let eroCode = AuthErrorCode(rawValue: error._code) {
                        switch eroCode {
                        case .invalidEmail:
                            self.showAlert("Enter a valid Email.")
                        case .emailAlreadyInUse:
                            self.showAlert("Email already in use.")
                        default:
                            self.showAlert("Error: \(error.localizedDescription)")
                        }
                    }
                    return
                }
                self.gotoDashBoard()
            })
        }
    }
    
    func showAlert(_ meassage: String) {
        
        let alertController = UIAlertController(title: "To Do App", message: meassage, preferredStyle: UIAlertController.Style.alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertAction.Style.default, handler: nil))
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    func gotoDashBoard(){
        
        let storyBoard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let dashboardVC = storyboard?.instantiateViewController(withIdentifier: "DashBoardViewController") as! DashBoardViewController
        self.navigationController?.pushViewController(dashboardVC, animated: true)
        
    }
    
    
    
    
    var validate:Bool{
        
        if (txtEmail.text?.trimmingCharacters(in: .whitespaces).isEmpty)!{
            let alert = UIAlertController(title: "Message" , message: "Plesse Enter Email" , preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(ok)
            self.present(alert,animated: true,completion: nil)
            return false
        }
        if (txtPassWord.text?.trimmingCharacters(in: .whitespaces).isEmpty)!{
            let alert = UIAlertController(title: "Message" , message: "Plesse Enter PassWord" , preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(ok)
            self.present(alert,animated: true,completion: nil)
            return false
        }
        return true
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
