//
//  IEXStock.swift
//  WatchSTOX
//
//  Created by Emmanuel Sanchez on 4/25/21.
//

import Foundation

class IEXStock {
    var token: String
    var symbol: String
    var watchlist = [String]()
    var stockList = [[String:Any]]()
    let BASE_URL: String
    
    init(token: String, symbol: String) {
        self.BASE_URL = "https://sandbox.iexapis.com/stable/stock"
        self.token = token
        self.symbol = symbol
    }
    
    func getQuote() {
        let url = URL(string: "\(self.BASE_URL)/\(self.symbol)/quote?token=\(self.token)")!
        var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        request.httpMethod = "GET"
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
           // This will run when the network request returns
           if let error = error {
              print(error.localizedDescription)
           } else if let data = data {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                self.stockList.append(dataDictionary!)
            self.watchlist.append(self.symbol)
            print(dataDictionary!)
//            WatchlistViewController.tableView.reloadData()
           }
        }
        task.resume()
    }
}
