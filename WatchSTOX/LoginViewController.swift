//
//  LoginViewController.swift
//  WatchSTOX
//
//  Created by Gazi Shahi on 4/17/21.
//

import UIKit
import Parse

class LoginViewController: UIViewController {
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var appTitle: UILabel!
    @IBOutlet weak var usernameText: UILabel!
    @IBOutlet weak var passwordText: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Set out default values
        let defaults = UserDefaults.standard
        defaults.setValue(false, forKey: "Dark Mode")
        defaults.setValue(false, forKey: "Notification Enabled")
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let defaults = UserDefaults.standard

        if defaults.bool(forKey: "Dark Mode") == true {
            self.view.backgroundColor = .darkGray
            appTitle
                .textColor = .white
            usernameText.textColor = .white
            passwordText.textColor = .white
        }
        else {
            self.view.backgroundColor = .white
            appTitle
                .textColor = .black
            usernameText.textColor = .black
            passwordText.textColor = .black
        }

    }
    
    @IBAction func onSignIn(_ sender: Any) {
        let username = usernameField.text!
        let password = passwordField.text!
        
        PFUser.logInWithUsername(inBackground: username, password: password) { (user, error) in
            if user != nil {
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            }
            else{
                print("Error: \(error?.localizedDescription)")
            }
        }
    }
    
    @IBAction func onSignUp(_ sender: Any) {
        let user = PFUser()
        user.username = usernameField.text
        user.password = passwordField.text
        
        user.signUpInBackground { (success, error) in
            if success {
                let watchlist = PFObject(className: "Watchlist")
                watchlist["symbolsList"] = [String]()
                watchlist["author"] = PFUser.current()!
                watchlist["watchCount"] = 0
                
                watchlist.saveInBackground() { (succes, error) in
                    if success {
                        print("Watchlist created.")
                        self.performSegue(withIdentifier: "loginSegue", sender: nil)
                    } else {
                        print("Error creating watchlist")
                    }
                }
            }
            else {
                print("Error: \(error?.localizedDescription)")
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
