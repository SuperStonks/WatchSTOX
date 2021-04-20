//
//  WatchlistViewController.swift
//  WatchSTOX
//
//  Created by Emmanuel Sanchez on 4/17/21.
//

import UIKit
import Parse

class WatchlistViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
//
//        https://cloud.iexapis.com/stable/stock/XOM/quote?token=YOUR_TOKEN_HERE
//        Using sandbox api: https://sandbox.iexapis.com/
//        Quote: GET /stock/{symbol}/quote/{field}
//        Logo: GET  /stock/{symbol}/logo
//
    
    @IBOutlet weak var tableView: UITableView!
    
    var watchlist = [String]()
    var stockList = [[String:Any]]()
    
    let IEXApiKey = "Tpk_1bae23b220964b8c8042c12c06d4e84c"
    
    
    func quoteDisplay(symbol: String) {

        let url = URL(string: "https://sandbox.iexapis.com/stable/stock/\(symbol)/quote?token=\(IEXApiKey)")!
//        let url = URL(string: "https://sandbox.iexapis.com/stable/stock/AAPL/chart/1y?token=\(IEXApiKey)")!
//        /stock/{symbol}/chart/{range}/{date}
        var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        request.httpMethod = "GET"
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
           // This will run when the network request returns
           if let error = error {
              print(error.localizedDescription)
           } else if let data = data {
            
//            let decodedApps = try JSONDecoder().decode(class.self, from: data!)
              let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            
//            self.stockList =  dataDictionary["results"] as! [[String:Any]]
//            self.tableView.reloadData()
//            self.stockList = dataDictionary!
//            let compName = self.stockList["companyName"] as! String
//            let count = self.stockList.count - 1
//            self.tableView.reloadData()
            self.stockList.append(dataDictionary!)


            let query = dataDictionary!
//            print("Company name is:", query["companyName"] as! String)
//            print(dataDictionary!)
//            print(type(of: dataDictionary))
            
//            print("hello")
//            print(self.watchlist)
//            print(self.stockList)
//            self.watchlist.append("MSFT")
//            self.watchlist.append("World")
//            print(dataDictionary["quoteResponse"] as? Any)
            
//            let iexRealtimePrice = dataDictionary!["iexRealtimePrice"]
//            print("This is the realtime random quote: $", iexRealtimePrice as! NSNumber)
//            let result = quoteResponse["result"] as! [[String:Any]]
//            print(result[0]["quoteSummary"])
            
            self.watchlist.append(symbol)
            print(self.watchlist)
            
            self.logoDisplay(symbol: symbol)
            self.tableView.reloadData()
           }
        }
        task.resume()
    }
    
    func logoDisplay(symbol: String) {
        
        let url = URL(string: "https://sandbox.iexapis.com/stable/stock/\(symbol)/logo?token=\(IEXApiKey)")!
        var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        request.httpMethod = "GET"
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
           // This will run when the network request returns
           if let error = error {
              print(error.localizedDescription)
           } else if let data = data {
            
            let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            let logo = dataDictionary!["url"] as! String
            
            print(logo)

        
            self.tableView.reloadData()
           }
        }
        task.resume()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        quoteDisplay(symbol: "AAPL")
        quoteDisplay(symbol: "TSLA")
        quoteDisplay(symbol: "MSFT")
//        logoDisplay(symbol: "AAPL")
        
        self.tableView.reloadData()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
//        quoteDisplay(symbol: "AAPL")
//        let query = PFQuery(className:"Posts")
//        query.includeKeys(["author", "comments", "comments.author"])
//        query.limit = 20
//
//        query.findObjectsInBackground() { (posts, error) in
//            if posts != nil {
//                self.posts = posts!
//                self.tableView.reloadData()
//            }
//
//        }

    }
    
    // MARK: - Table view data source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        print("Watchlist count is:", watchlist.count)
//        print(stockList["companyName"])
//        let companyName = stockList["companyName"] as! String
//        print("this is the stocklist", stockList)
//        print(companyName.count)
//        self.tableView.reloadData()
        return watchlist.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let stock = stockList[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "WatchlistCell") as! WatchlistCell
        
        let companyName = stock["companyName"] as! String
        let symbol = stock["symbol"] as! String
        let latestPrice = stock["latestPrice"] as! NSNumber
//        print("latestPrice:", latestPrice)
        let latestPriceString = "\(latestPrice)"
            
        cell.companyName.text = companyName
        cell.tickerSymbol.text = symbol
        cell.stockPrice.text = latestPriceString
            
        return cell

        
        // good code
//        let cell = tableView.dequeueReusableCell(withIdentifier: "WatchlistCell") as! WatchlistCell
////        let stockDisplay = watchlist[indexPath.row]
//        let companyName = stockList["companyName"] as! String
//        let symbol = stockList["symbol"] as! String
//        let latestPrice = stockList["latestPrice"] as! NSNumber
//        print(latestPrice)
//        let latestPriceString = "\(latestPrice)"
//
//        cell.companyName.text = companyName
//        cell.tickerSymbol.text = symbol
//        cell.stockPrice.text = latestPriceString
//        return cell
    }
    
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destination.
//        // Pass the selected object to the new view controller.
//
//        print("Loading up the screen")
//
//        // Find the selected stock
//        let cell = sender as! UITableViewCell
//        let indexPath = tableView.indexPath(for: cell)!
//        let movie = stockList[indexPath.row]
//
//        // Pass the selecte movie to the details view controller
//        let stockDetailsViewController = segue.destination as! StockDetailsViewController
//        stockDetailsViewController.stock = stock
//
//        tableView.deselectRow(at: indexPath, animated: true)
//
//    }
    


    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

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

    
    @IBAction func onLogoutButton(_ sender: Any) {
        PFUser.logOut()
        
        let main = UIStoryboard(name: "Main", bundle: nil)
        let loginViewController = main.instantiateViewController(identifier: "LoginViewController")
        
        let delegate = self.view.window?.windowScene?.delegate as! SceneDelegate
        
        delegate.window?.rootViewController = loginViewController
        
    }
}
