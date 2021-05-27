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
class SearchViewController: UIViewController, UITableViewDataSource, UISearchResultsUpdating, UITableViewDelegate {
    

    var data = ["AAPL", "MSFT", "TSLA", "JBLU", "AMZN", "AA", "RIOT", "AMC", "BNGO", "PLUG", "PLTR", "GE", "F", "OCGN", "FSR", "AAL"]
    var filterData: [String]!
    var searchController: UISearchController!
    var stockList = [[String:Any]]()

    
//    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var watchlistSwitch: UISwitch!
    
    
    func quoteDisplay(symbol: String) {
        let IEXApiKey: String = "Tpk_1bae23b220964b8c8042c12c06d4e84c"
        let BASE_URL: String = "https://sandbox.iexapis.com/stable/stock"
        let url = URL(string: "\(BASE_URL)/\(symbol)/quote?token=\(IEXApiKey)")!
        var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        request.httpMethod = "GET"
        print(symbol)
        print(url)

        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
//        let session = URLSession()
        print("start the task to retrieve stock data")
        let task = session.dataTask(with: request) { [self] (data, response, error) in
        // This will run when the network request returns
        if let error = error {
           print(error.localizedDescription)
        } else if let data = data {
         
           let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            print(dataDictionary!)
            
            self.stockList.append(dataDictionary!)
           }
        }
        print("getting stock finished")
        task.resume()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.dataSource = self
        tableView.delegate = self
//        searchBar.delegate = self
        filterData = data
        
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.sizeToFit()
        tableView.tableHeaderView = searchController.searchBar
        searchController.searchBar.placeholder = "Search Symbols"
        searchController.obscuresBackgroundDuringPresentation = false
//        navigationItem.searchController = searchController

        definesPresentationContext = true
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
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchCell", for: indexPath) as! SearchCell
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchCell")! as! SearchCell
        
        cell.tickerSymbol.text = filterData[indexPath.row]
        
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterData.count
    }

    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text {
            filterData = searchText.isEmpty ? data : data.filter({ (dataString: String) -> Bool in
                return dataString.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
            })
        }
        
        tableView.reloadData()
    }
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
////        filterData = searchText.isEmpty ? stocks : stocks.filter({ (item: String) -> Bool in
////            return item.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
////        })
//        if let searchText = searchController.searchBar.text {
//            filterData = searchText.isEmpty ? stocks : stocks.filter({ (dataString: String) -> Bool in
//                return dataString.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
//            })
//        }
//
//        tableView.reloadData()
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
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCell = filterData[indexPath.row]
        
        print(selectedCell)
        
    }
    
//    var isSearchBarEmpty: Bool {
//      return searchController.searchBar.text?.isEmpty ?? true
//    }
//
//    var isFiltering: Bool {
//      return searchController.isActive && !isSearchBarEmpty
//    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.

        print("Loading up the details screen")

        // Find the selected ticker symbol
        let cell = sender as! SearchCell
        let indexPath = tableView.indexPath(for: cell)!
        print(indexPath)
        
//        var symbol = ""
//        if isFiltering {
//          symbol = filterData[indexPath.row]
//        } else {
//          symbol = data[indexPath.row]
//        }
        print(indexPath.row)
        
//        quoteDisplay(symbol: symbol)
        print("this is symbol:", filterData[indexPath.row])
//        quoteDisplay(symbol: filterData[indexPath.row])
        
//        print(stockList)
        
//        var asdf: [String: Any]!
//        print(asdf)
//        let stock = stockList[0]

        // Pass the selected movie to the details view controller
        let detailsViewController = segue.destination as! StockDetailsViewController
//        detailsViewController.stock = stock
        detailsViewController.stockSymbol = filterData[indexPath.row]

        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    @IBAction func onLogoutButton(_ sender: Any) {
        
        let main = UIStoryboard(name: "Main", bundle: nil)
        let loginViewController = main.instantiateViewController(identifier: "LoginViewController")
        
        let delegate = self.view.window?.windowScene?.delegate as! SceneDelegate
        
        delegate.window?.rootViewController = loginViewController
    }
    
    @IBAction func checkWatchlist(_ sender: Any) {
    }
    
}
