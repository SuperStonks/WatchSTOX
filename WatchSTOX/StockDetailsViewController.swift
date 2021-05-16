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
    var stock: [String:Any]!
    
    let IEXApiKey: String = "Tpk_1bae23b220964b8c8042c12c06d4e84c"
    let BASE_URL: String = "https://sandbox.iexapis.com/stable/stock"
    
    func quoteDisplay(symbol: String) {

        let url = URL(string: "\(BASE_URL)/\(symbol)/?token=\(self.IEXApiKey)")!
        var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        request.httpMethod = "GET"
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { [self] (data, response, error) in
           // This will run when the network request returns
           if let error = error {
              print(error.localizedDescription)
           } else if let data = data {
            
              let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
//            self.stockList.append(dataDictionary!)
            print(dataDictionary)
//            let query = dataDictionary!

//            self.watchlist.append(symbol)
            
//            self.logoDisplay(symbol: symbol)
//            self.tableView.reloadData()
           }
        }
        task.resume()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        print(stock)
//        quoteDisplay(symbol: <#T##String#>)
//        for item in stock {
//            print("thing: \(item)")
        var symbol = ""
        for (key, value) in stock {
                print("\(key) -> \(value)")
            if key == "companyName" {
                companyName.text = value as! String
            } else if key == "symbol" {
                tickerSymbol.text = value as! String
                symbol = value as! String
            } else if key == "latestPrice" {
                let latestPriceNum = value as! NSNumber
                let latestPriceString = "\(latestPriceNum)"
                stockPrice.text = latestPriceString
            } else if key == "high" {
                let num = value as! NSNumber
                let numString = "\(num)"
                todayHigh.text = numString
            } else if key == "low" {
                let num = value as! NSNumber
                let numString = "\(num)"
                todayLow.text = numString
            } else if key == "week52High" {
                let num = value as! NSNumber
                let numString = "\(num)"
                weekFTHigh.text = numString
            } else if key == "week52Low" {
                let num = value as! NSNumber
                let numString = "\(num)"
                weekFTLow.text = numString
            } else if key == "marketCap" {
                let num = value as! NSNumber
                let numString = "\(num)"
                marketCap.text = numString
            } else if key == "volume" {
                let num = value as! NSNumber
                let numString = "\(num)"
                volumeLabel.text = numString
            } else if key == "changePercent" {
                let num = value as! NSNumber
                let numString = "\(num)"
                changePercent.text = numString
            } else if key == "previousClose" {
                let num = value as! NSNumber
                let numString = "\(num)"
                previousClose.text = numString
            } else if key == "avgTotalVolume" {
                let num = value as! NSNumber
                let numString = "\(num)"
                avgTotalVolume.text = numString
            }
        }
        
        let logoPath = "https://storage.googleapis.com/iex/api/logos/\(symbol).png"

        print("logoPath:", logoPath)

        let logoURL = URL(string: logoPath)
        logoView.af.setImage(withURL: logoURL!)
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
