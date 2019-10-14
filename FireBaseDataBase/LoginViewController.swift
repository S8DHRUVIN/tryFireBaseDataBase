//
//  LoginViewController.swift
//  FireBaseDataBase
//
//  Created by Dhruvin Shiyani on 24/09/19.
//  Copyright © 2019 Dhruvin Shiyani. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
//

class LoginViewController: UIViewController {
    
    
    
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassWord: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func btnActionLogin(_ sender: Any) {
        
        //
        if validate{
            
            Auth.auth().createUser(withEmail: txtEmail.text!, password: txtPassWord.text!, completion: { (user, error) in
                guard let _ = user else {
                if let error = error {
                    if let errCode = AuthErrorCode(rawValue: error._code) {
                        switch errCode {
                        case .userNotFound:
                            self.showAlert("Enter a valid Email.")
                        case .wrongPassword:
                            self.showAlert("Email already in use.")
                        default:
                            self.showAlert("Error: \(error.localizedDescription)")
                        }
                    }
                    return
                }
                return
                    //  self.gotoDashBoard()
                }
            })
            self.gotoDashboard()
        }
        
    }
    
    @IBAction func btnActionRegister(_ sender: Any) {
        
        let storyBoard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let RegisterVC = storyboard?.instantiateViewController(withIdentifier: "SingUpViewController") as! SingUpViewController
        self.navigationController?.pushViewController(RegisterVC, animated: true)
        
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
    
    func showAlert(_ message: String)
    {
        let alert = UIAlertController(title: "To Do App", message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func gotoDashboard()
    {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let DaseboardVC = storyBoard.instantiateViewController(withIdentifier: "DashBoardViewController") as! DashBoardViewController
        self.navigationController?.pushViewController(DaseboardVC, animated: true)
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
