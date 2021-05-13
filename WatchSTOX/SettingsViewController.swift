//
//  SettingsViewController.swift
//  WatchSTOX
//
//  Created by Mike Neri on 4/29/21.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var darkModeText: UILabel!
    @IBOutlet weak var darkModeSwitch: UISwitch!
    @IBOutlet weak var notificationText: UILabel!
    @IBOutlet weak var notificationSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func enableDark() {
        self.view.backgroundColor = .darkGray
        darkModeText.textColor = .white
        notificationText.textColor = .white
    }
    
    func disableDark(){
        self.view.backgroundColor = .white
        darkModeText.textColor = .black
        notificationText.textColor = .black
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("view will appear")
        let defaults = UserDefaults.standard
        
        // Make sure we are changing modes
        if defaults.bool(forKey: "Dark Mode") == true{
            darkModeSwitch.setOn(true, animated: true)
            enableDark()
        }
        else {
            disableDark()
        }
    }

    
    
    @IBAction func changeSettings(_ sender: Any) {
            let defaults = UserDefaults.standard
    
            // Check initial mode and update
            let darkEnabled = darkModeSwitch.isOn
            defaults.setValue(darkEnabled, forKey: "Dark Mode")
            let notificationEnabled = notificationSwitch.isOn
            defaults.setValue(notificationEnabled, forKey: "Notification Enabled")
    
            if darkEnabled == true {
                enableDark()
            }
            else {
                disableDark()
            }
    
    
            defaults.synchronize()
    }


    @IBAction func onLogoutButton(_ sender: Any) {
        
        let main = UIStoryboard(name: "Main", bundle: nil)
        let loginViewController = main.instantiateViewController(identifier: "LoginViewController")
        
        let delegate = self.view.window?.windowScene?.delegate as! SceneDelegate
        
        delegate.window?.rootViewController = loginViewController
    }
    
    @IBAction func onChangePasswordButton(_ sender: Any) {
        self.performSegue(withIdentifier: "changePassword", sender: nil)
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
