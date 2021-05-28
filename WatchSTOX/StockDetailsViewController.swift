//
//  StockDetailsViewController.swift
//  WatchSTOX
//
//  Created by Mike Neri on 5/15/21.
//

import UIKit
import Parse

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
    
    // These outlets are just labels
    @IBOutlet weak var companyNameLabel: UILabel!
    @IBOutlet weak var stockPriceLabel: UILabel!
    @IBOutlet weak var tickerSymbolLabel: UILabel!
    @IBOutlet weak var todayHighLabel: UILabel!
    @IBOutlet weak var todayLowLabel: UILabel!
    @IBOutlet weak var weekFTHighLabel: UILabel!
    @IBOutlet weak var weekFTLowLabel: UILabel!
    @IBOutlet weak var marketCapLabel: UILabel!
    @IBOutlet weak var volumeLabelLabel: UILabel!
    @IBOutlet weak var changePercentLabel: UILabel!
    @IBOutlet weak var previousCloseLabel: UILabel!
    @IBOutlet weak var avgTotalVolumeLabel: UILabel!
    @IBOutlet weak var watchLabel: UILabel!
    
    var stock: [String:Any]!
    var stockSymbol: String!
    var isItOnTheList = false
    
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
        let defaults = UserDefaults.standard

        if defaults.bool(forKey: "Dark Mode") == true {
            companyName.textColor = .white
            stockPrice.textColor = .white
            tickerSymbol.textColor = .white
            todayHigh.textColor = .white
            todayLow.textColor = .white
            weekFTHigh.textColor = .white
            weekFTLow.textColor = .white
            marketCap.textColor = .white
            volumeLabel.textColor = .white
            changePercent.textColor = .white
            previousClose.textColor = .white
            avgTotalVolume.textColor = .white
            
            // Label texts
            companyNameLabel.textColor = .white
            stockPriceLabel.textColor = .white
            tickerSymbolLabel.textColor = .white
            todayHighLabel.textColor = .white
            todayLowLabel.textColor = .white
            weekFTHighLabel.textColor = .white
            weekFTLowLabel.textColor = .white
            marketCapLabel.textColor = .white
            volumeLabelLabel.textColor = .white
            changePercentLabel.textColor = .white
            previousCloseLabel.textColor = .white
            avgTotalVolumeLabel.textColor = .white
            watchLabel.textColor = .white
        }
        else {
            companyName.textColor = .black
            stockPrice.textColor = .black
            tickerSymbol.textColor = .black
            todayHigh.textColor = .black
            todayLow.textColor = .black
            weekFTHigh.textColor = .black
            weekFTLow.textColor = .black
            marketCap.textColor = .black
            volumeLabel.textColor = .black
            changePercent.textColor = .black
            previousClose.textColor = .black
            avgTotalVolume.textColor = .black
            
            // Label texts
            companyNameLabel.textColor = .black
            stockPriceLabel.textColor = .black
            tickerSymbolLabel.textColor = .black
            todayHighLabel.textColor = .black
            todayLowLabel.textColor = .black
            weekFTHighLabel.textColor = .black
            weekFTLowLabel.textColor = .black
            marketCapLabel.textColor = .black
            volumeLabelLabel.textColor = .black
            changePercentLabel.textColor = .black
            previousCloseLabel.textColor = .black
            avgTotalVolumeLabel.textColor = .black
            watchLabel.textColor = .black
        }
        
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
//        print("testing adding")
//        var test = ["hello", "this", "is", "a", "watchlist"]
//        print(test)
//        let theSymbol = "nerd"
//        test.append(theSymbol)
//        print(test)
        
//        var query = PFQuery(className: "Watchlist")
//        query.whereKey("author", equalTo: PFUser.current()!)
//        query.findObjectsInBackground() {
//            (parseObject: PFObject?, error: NSError?) in
//            if error != nil {
//                print(error)
//            } else if parseObject != nil {
//                parseObject["watchCount"] = (parseObject["watchCount"] as! Int) + 1
//                var oldArray = parseObject["symbolsList"] as! NSArray
//                var newArray = []
//                for object in oldArray {
//                    let stockSym = object as? String
//                    newArray.append(stockSym)
//                }
//                oldArray.append(stockSymbol)
//                parseObject["symbolsList"] = newArray
//                parseObject = PFUser.current()!
//            }
//        }
        
        // SHDFIASDFDSKFWND
        
        
//        query.findObjectsInBackground() {
//            (parseObject: PFObject?, error: NSError?) -> Void in
//            if error != nil {
//                print(error)
//            } else if parseObject != nil {
//                parseObject["watchCount"] = (parseObject["watchCount"] as! Int) + 1
//                var oldArray = parseObject["symbolsList"] as! NSArray
//                var newArray = []
//                for object in oldArray {
//                    let stockSym = object as? String
//                    newArray.append(stockSym)
//                }
//                oldArray.append(stockSymbol)
//                parseObject["symbolsList"] = newArray
//                parseObject = PFUser.current()!
////                parseObject["symbolsList"] =
//
//            }
//        }
        
        // ASDANSFKAKFNA
//        let query = PFQuery(className:"Watchlist")
//        let userId = PFUser.current()?.objectId as! String
//        query.getObjectInBackground(withId: userId) { (parseObject: PFObject?, error: Error?) in
//            if let error = error {
//                print(error.localizedDescription)
//            } else if let parseObject = parseObject {
//                var array = parseObject["symbolsList"] as! [String]
//                array.append(self.stockSymbol)
//                parseObject["symbolsList"] = array
//                parseObject["watchCount"] =  parseObject["watchCount"] as! Int + 1
//                parseObject.saveInBackground()
//            }
//        }
        let query = PFQuery(className:"Watchlist")
        let userId = PFUser.current()?.objectId as! String
        print("THIS IS THE USER'S ID:", userId)
        query.whereKey("author", equalTo: userId)
        query.findObjectsInBackground { (objects: [PFObject]?, error: Error?) in
            if let error = error {
                // Log details of the failure
                print(error.localizedDescription)
            } else if var objects = objects {
                // The find succeeded.
                print("Successfully retrieved objects")
                // Do something with the found objects
                for var object in objects {
//                    print(object.objectId as Any)
//                    print(object["author"] as Any)
//                    print(object["symbolsList"] as! [String])
                    var array = object["symbolsList"] as! [String]
//                    for sym in array {
//                        let symString = sym as! String
//                        if symString == self.stockSymbol {
//                            self.watchlistSwitch.isOn = true
//                            break
//                        }
//                    }
                    array.append(self.stockSymbol)
                    object["symbolsList"] = array
                    object.saveInBackground()
                    break

                }
            }
        }

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
//        print("checking if symbol is in watchlist")
//        var test = ["hello", "this", "is", "a", "watchlist"]
//        var isOnList = false
//        for item in test {
//            if (item == "a") {
//                print("it is in the watchlist!")
//                isOnList = true
//                break
//            }
//            else {
//                isOnList = false
//                print("it is not in the watchlist")
//            }
//        }
        
        
        
//
//        var query = PFQuery(className:"Watchlist")
//        query.whereKey("author", equalTo: PFUser.current()!)
//        query.includeKey("symbolsList")
//        query.findObjectsInBackground() { (watchlistObj, error) in
//            if watchlistObj != nil {
//                let array = watchlistObj?[0]["symbolsList"] as! NSArray
//                print("this is symbol list:",array)
//
//                for object in array {
//                    if let stockSym = object as? String {
//                        print(stockSym)
//                        if self.stockSymbol == stockSym {
//                            self.isItOnTheList = false
//                        }
//                    }
//                }
////                for item in watchlistObj {
////
////                    print("this is a :", item)
////                }
//            }
//        }
//        let query = PFQuery(className:"Watchlist")
//        let userId = PFUser.current()?.objectId as! String
//        query.getObjectInBackground(withId: "userId") { (watchlistObject, error) in
//            if error == nil {
//                // Success!
//                let array = watchlistObject?["symbolsList"] as! [String]
//                for item in array {
//                    let symbolInList = item as! String
//                    if symbolInList == self.stockSymbol {
//                        self.watchlistSwitch.isOn = true
//                    }
//                }
//            } else {
//                // Fail!
//                print(error)
//            }
//        }
        let query = PFQuery(className:"Watchlist")
        let userId = PFUser.current()?.objectId as! String
        print("THIS IS THE USER'S ID:", userId)
        query.whereKey("author", equalTo: userId)
        query.findObjectsInBackground { (objects: [PFObject]?, error: Error?) in
            if let error = error {
                // Log details of the failure
                print(error.localizedDescription)
            } else if let objects = objects {
                // The find succeeded.
                print("Successfully retrieved objects")
                // Do something with the found objects
                for object in objects {
                    print(object.objectId as Any)
                    print(object["author"] as Any)
                    print(object["symbolsList"] as! [String])
                    let array = object["symbolsList"] as! [String]
                    for sym in array {
                        let symString = sym as! String
                        if symString == self.stockSymbol {
                            self.watchlistSwitch.isOn = true
                            break
                        }
                    }
                }
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
//            addToWatchlist()
//            removeFromWatchlist()
//            splitWatchlist()
//            checkIfInWatchlist()
//            populateDetailView()
        } else {
            print("segue from watchlist view")
            populateDetailView()
        }
        print("hello?")
        

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
//        checkIfInWatchlist()
//        if isItOnTheList {
//            watchlistSwitch.isOn = true
//        } else {
//            watchlistSwitch.isOn = false
//        }
//        populateDetailView()
        let defaults = UserDefaults.standard

        if defaults.bool(forKey: "Dark Mode") == true {
            self.view.backgroundColor = .darkGray

        }
        else {
            self.view.backgroundColor = .white
        }
        
//        checkIfInWatchlistUserDefaults()


    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        print("view did appear")
        populateDetailView()
        
        
        checkIfInWatchlistUserDefaults()

//
//        checkIfInWatchlist()
        
        
        
        
        
//        if self.isItOnTheList == true {
//            self.watchlistSwitch.isOn = true
//        } else {
//            self.watchlistSwitch.isOn = false
//        }
//        populateDetailView()
//        checkIfInWatchlist()
//        if isItOnTheList {
//            watchlistSwitch.isOn = true
//        } else {
//            watchlistSwitch.isOn = false
//        }
    }
    
    
    
    @IBAction func isOnWatchlist(_ sender: Any) {
        let switchList = watchlistSwitch.isOn
        if switchList {
//            addToWatchlist()
            addToWatchlistUserDefaults()
        } else {
//            removeFromWatchlist()
            removeFromWatchlistUserDefaults()
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
    
    func checkIfInWatchlistUserDefaults() {
        let defaults = UserDefaults.standard
        
        var strings: [String] = defaults.stringArray(forKey: "Userdefaultlist") ?? []
        
        if strings.count == 0 {
            self.watchlistSwitch.isOn = false
        } else {
            for stock in strings {
                if stock == tickerSymbol.text {
                    watchlistSwitch.setOn(true, animated: true)
                    print("it is in the list")
                }
//                else {
//                    self.watchlistSwitch.setOn(false, animated: true)
//                    print("it is not in the list")
//                }
            }
        }
        
        print("is it on the list?", strings)
        print("this is the symbol", stockSymbol)

        print("yo finished checking the list")
    }

    func addToWatchlistUserDefaults() {
        let defaults = UserDefaults.standard
        
        var strings: [String] = defaults.stringArray(forKey: "Userdefaultlist") ?? []
        
        strings.append(stockSymbol)
        
        defaults.set(strings, forKey: "Userdefaultlist")
        
        defaults.synchronize()
    }
    
    func removeFromWatchlistUserDefaults() {
        print("removing from watchlist")
        let defaults = UserDefaults.standard
        
        var strings: [String] = defaults.stringArray(forKey: "Userdefaultlist") ?? []
        
        print("watchlist in question:", strings)
        print("removing:", tickerSymbol.text)
        var index = 0
        for stock in strings {
            if stock == tickerSymbol.text {
                strings.remove(at: index)
                break
            }
            index += 1
        }
        print("watchlist after removing:", strings)
        
        defaults.set(strings, forKey: "Userdefaultlist")
        
        defaults.synchronize()
    }
}
