//
//  VerifyViewController.swift
//  WatchSTOX
//
//  Created by Mike Neri on 4/29/21.
//

import UIKit
import Parse

class VerifyViewController: UIViewController {

    
    @IBOutlet weak var newPasswordLabel: UILabel!
    @IBOutlet weak var retypePasswordLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    @IBOutlet weak var newPasswordField: UITextField!
    @IBOutlet weak var retypePasswordField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let defaults = UserDefaults.standard

        if defaults.bool(forKey: "Dark Mode") == true {
            self.view.backgroundColor = .darkGray
            newPasswordLabel.textColor = .white
            retypePasswordLabel.textColor = .white
            emailLabel.textColor = .white
        }
        else {
            self.view.backgroundColor = .white
            newPasswordLabel.textColor = .black
            retypePasswordLabel.textColor = .black
            emailLabel.textColor = .black
        }

    }
    
    @IBAction func onCancelButton(_ sender: Any) {
        dismiss (animated: true, completion: nil)
    }
    
    @IBAction func onConfirmButton(_ sender: Any) {
        let newPassword = newPasswordField.text!
        let retypePassword = retypePasswordField.text!
        let email = emailField.text!
        
        if (newPassword == retypePassword) {
//            PFUser.requestPasswordReset(forEmail: email){(user, error) in
//                if user != nil {
//                    dismiss(animated: true, completion: nil)
//                }
//                else {
//                    print("Error: \(error?.localizedDescription)")
//
//                }
//            }
            
            do {
                try PFUser.requestPasswordReset(forEmail: email)
            }
            catch _ {
                print("Error requesting password reset.")
            }
        }
        else {
            let alert = UIAlertController(title: "Error", message: "Passwords don't match. Try Again", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
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
