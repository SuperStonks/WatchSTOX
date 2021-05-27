//
//  StockDetailsViewController.swift
//  WatchSTOX
//
//  Created by Mike Neri on 5/15/21.
//

import UIKit

class StockDetailsViewController: UIViewController {

    @IBOutlet weak var logoView: UIImageView!
    @IBOutlet weak var companyName: UILabel!
    @IBOutlet weak var tickerSymbol: UILabel!
    @IBOutlet weak var stockPrice: UILabel!
    @IBOutlet weak var todayHigh: UILabel!
    @IBOutlet weak var todayLow: UILabel!
    
    @IBOutlet weak var weekFTHigh: UILabel!
    @IBOutlet weak var weekFTLow: UILabel!
    @IBOutlet weak var marketCap: UILabel!
    @IBOutlet weak var volumeLabel: UILabel!
    @IBOutlet weak var changePercent: UILabel!
    @IBOutlet weak var previousClose: UILabel!
    @IBOutlet weak var avgTotalVolume: UILabel!
    
    @IBOutlet weak var watchlistSwitch: UISwitch!
    
    
    var stock: [String:Any]!
    var stockSymbol: String!
    
    let IEXApiKey: String = "Tpk_1bae23b220964b8c8042c12c06d4e84c"
    let BASE_URL: String = "https://sandbox.iexapis.com/stable/stock"
    
    func quoteDisplay(symbol: String) {
        let IEXApiKey: String = "Tpk_1bae23b220964b8c8042c12c06d4e84c"
        let BASE_URL: String = "https://sandbox.iexapis.com/stable/stock"
        let url = URL(string: "\(BASE_URL)/\(symbol)/quote?token=\(IEXApiKey)")!
        var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 20)
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
            
//            self.stock.append(dataDictionary!)
            self.stock = dataDictionary!
//            print(stock!)
           }
        }
//        print(stock! as Any)
        print("getting stock finished")
        task.resume()
    }
    
    func populateDetailView() {
        var symbol = ""
        for (key, value) in stock {
                print("\(key) -> \(value)")
            if key == "companyName" {
                companyName.text = value as! String
            } else if key == "symbol" {
                tickerSymbol.text = value as! String
                symbol = value as! String
            } else if key == "latestPrice" {
                if (type(of: value)) == NSNull.self {
                    stockPrice.text = "Unavailable"
                } else {
                    let latestPriceNum = value as! NSNumber
                    let latestPriceString = "\(latestPriceNum)"
                    stockPrice.text = latestPriceString
                }
            } else if key == "high" {
                if (type(of: value)) == NSNull.self {
                    todayHigh.text = "Unavailable"
                } else {
                    let num = value as! NSNumber
                    let numString = "\(num)"
                    todayHigh.text = numString
                }
            } else if key == "low" {
                if (type(of: value)) == NSNull.self {
                    todayLow.text = "Unavailable"
                } else {
                    let num = value as! NSNumber
                    let numString = "\(num)"
                    todayLow.text = numString
                }
            } else if key == "week52High" {
                if (type(of: value)) == NSNull.self {
                    weekFTHigh
                        .text = "Unavailable"
                } else {
                    let num = value as! NSNumber
                    let numString = "\(num)"
                    weekFTHigh.text = numString
                }
            } else if key == "week52Low" {
                if (type(of: value)) == NSNull.self {
                    weekFTLow.text = "Unavailable"
                } else {
                    let num = value as! NSNumber
                    let numString = "\(num)"
                    weekFTLow.text = numString
                }
            } else if key == "marketCap" {
                if (type(of: value)) == NSNull.self {
                    marketCap.text = "Unavailable"
                } else {
                    let num = value as! NSNumber
                    let numString = "\(num)"
                    marketCap.text = numString
                }
            } else if key == "volume" {
                if (type(of: value)) == NSNull.self {
                    volumeLabel.text = "Unavailable"
                } else {
                    let num = value as! NSNumber
                    let numString = "\(num)"
                    volumeLabel.text = numString
                }
            } else if key == "changePercent" {
                if (type(of: value)) == NSNull.self {
                    changePercent.text = "Unavailable"
                } else {
                    let num = value as! NSNumber
                    let numString = "\(num)"
                    changePercent.text = numString
                }
            } else if key == "previousClose" {
                if (type(of: value)) == NSNull.self {
                    previousClose.text = "Unavailable"
                } else {
                    let num = value as! NSNumber
                    let numString = "\(num)"
                    previousClose.text = numString
                }
            } else if key == "avgTotalVolume" {
                if (type(of: value)) == NSNull.self {
                    avgTotalVolume.text = "Unavailable"
                } else {
                    let num = value as! NSNumber
                    let numString = "\(num)"
                    avgTotalVolume.text = numString
                }
            }
        }
        
        let logoPath = "https://storage.googleapis.com/iex/api/logos/\(symbol).png"

        print("logoPath:", logoPath)

        let logoURL = URL(string: logoPath)
        logoView.af.setImage(withURL: logoURL!)
    }
    
    func addToWatchlist() {
        print("testing adding")
        var test = ["hello", "this", "is", "a", "watchlist"]
        print(test)
        let theSymbol = "nerd"
        test.append(theSymbol)
        print(test)
    }
    
    func removeFromWatchlist() {
        print("removing from watch list")
        var test = ["hello", "this", "is", "a", "watchlist"]
        print(test)
        let find = "is"
        for (index, element) in test.enumerated() {
            print("Item \(index): \(element)")
            if (element == find) {
                test.remove(at: index)
                break
            }
        }
        
        print(test)
    }
    
    func splitWatchlist() {
        print("spltting watchlist for watchlist")
        var test = ["hello", "this", "is", "a", "watchlist"]
        for item in test {
            print(item)
        }
    }
    
    func checkIfInWatchlist() {
        print("checking if symbol is in watchlist")
        var test = ["hello", "this", "is", "a", "watchlist"]
        var isOnList = false
        for item in test {
            if (item == "a") {
                print("it is in the watchlist!")
                isOnList = true
                break
            }
            else {
                isOnList = false
                print("it is not in the watchlist")
            }
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        print(stock)
//        quoteDisplay(symbol: <#T##String#>)
//        for item in stock {
//            print("thing: \(item)")
        
        print("stock symbol is :", stockSymbol)
        
        if stock == nil {
            print("segue from search view")
            do {
                quoteDisplay(symbol: stockSymbol)
                sleep(3)
            }
            addToWatchlist()
            removeFromWatchlist()
            splitWatchlist()
            checkIfInWatchlist()
//            populateDetailView()
        } else {
            print("segue from watchlist view")
            populateDetailView()
        }
        print("hello?")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        print("view did appear")
        populateDetailView()
    }
    
    
    @IBAction func isOnWatchlist(_ sender: Any) {
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
