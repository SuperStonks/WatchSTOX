//
//  SearchViewController.swift
//  WatchSTOX
//
//  Created by Mike Neri on 4/29/21.
//

import UIKit
import Parse
import AlamofireImage

//UITableViewDataSource, UITableViewDelegate
class SearchViewController: UIViewController  {
    var searchActive = false
    var stock = ["AAPL", "MSFT", "TSLA", "JBLU", "AMZN", "AA", "RIOT", "AMC", "BNGO", "PLUG", "PLTR", "GE", "F", "OCGN", "FSR", "AAL"]
    var filterData: [String] = []
    
    @IBOutlet weak var searchBar: UISearchBar!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let defaults = UserDefaults.standard

        if defaults.bool(forKey: "Dark Mode") == true {
            self.view.backgroundColor = .darkGray
        }
        else {
            self.view.backgroundColor = .white
        }

    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchActive = true
    }
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchActive = false
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false

    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filterData = stock
        if searchText.isEmpty == false { stock.filter({ $0.contains(searchText)})
        }
    }
    

//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if searchActive {
//            return filterData.count
//        }
//        return stock.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! SearchStockCell
//        if searchActive {
//            cell.companyLabel.text = filterData[indexPath.row]
//        } else {
//            cell.companyLabel.text = stock[indexPath.row]
//        }
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") else { return; default nil }
//        return cell
//    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    @IBAction func onLogoutButton(_ sender: Any) {
        
        let main = UIStoryboard(name: "Main", bundle: nil)
        let loginViewController = main.instantiateViewController(identifier: "LoginViewController")
        
        let delegate = self.view.window?.windowScene?.delegate as! SceneDelegate
        
        delegate.window?.rootViewController = loginViewController
    }
    
}
