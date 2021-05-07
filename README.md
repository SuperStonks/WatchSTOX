# WatchSTOX

## Table of Contents
1. [Overview](#Overview)
1. [Product Spec](#Product-Spec)
1. [Wireframes](#Wireframes)
2. [Schema](#Schema)

## Overview
### Description
Simple stock tracking app which lets you watch your favorite stocks, and browse different ones as well. 
Could potentially be used as a stock simulator in the future or an easy way of checking stocks daily without having
to search them up.

### App Evaluation

- **Category:** Finance / Simulation
- **Mobile:** This app would be primarily developed for mobile and would probably be useful on PC as
well depending if we add a simulation aspect. The mobile version would definitely be more handy as
it would be used constantly to check stocks rather than turning on a PC to check stocks.
- **Story:** Stores your favorite stocks on a watch list and let's you customise which ones are worth
putting on your home tab. 
- **Market:** Although there are many similar apps, this is straight to the point and it's available to
all ages.
- **Habit:** This app would be used daily as stocks change day by day and it's also up to the user's 
discretion on how often they want to check stock prices.
- **Scope:** First we will start on implementing stock watches/favorites and stock searching. Maybe then
we can add ways to show and analyze the stock market, i.e. which stock had the biggest gain or dip. Going
further we can add a simulation tab which provides you with fake money and let's you invest as if it was real
and the fake portfolio changes with real time stock exchange prices.

### App Sprint-1 GIF

![Walkthrough](https://media2.giphy.com/media/bs1bK6DyvHZeAqC4Ye/giphy.gif?cid=790b76118c669e407e8c6a3cd65a79e2708197493cd2351d&rid=giphy.gif&ct=g)

## Product Spec

### 1. User Stories (Required and Optional)

**Required Must-have Stories**

* [X] User can sign up and login 
* [X] User stays logged in
* [ ] User can change password
* [ ] User can search for stocks
* [ ] User can filter through certain stocks
* [ ] User can add stocks to be placed on a watchlist
* [ ] User can remove stocks from watchlist
* [ ] User can look at detailed stock information
* [X] User can change to Dark Mode
* [X] User can disable/enable notifications
* [ ] User can receive notifications

**Optional Nice-to-have Stories**

* [ ] User can see the top stock gains/losses that week
* [ ] User can invest fake money into different stocks
* [ ] User receives real time calculated investment earnings of said fake money
* [ ] User can also see crypto-currency exchange

### 2. Screen Archetypes

* Login
* Register - User can sign up, log-in, or auto-log into their account
   * On first download, user is required to register.
   * User must login if they already have an account, then they will be auto-logged in.
* Home/Watch-list Screen
   * Here are the preferences and stocks said user has chosen to put on their "watch-list."
* Stock Search Screen
   * Allows the user to look up any stocks available; look at the stock detail such as gains and losses. 
   * Also enables user to chose any stock to put on their watch-list.
* Settings Screen
   * Allows the user to change preferences, edit account settings, enable dark mode.

### 3. Navigation

**Tab Navigation** (Tab to Screen)

* Home/Watch-list
* Stock Search
* Settings

Optional:

* Top Gains/Losses Stock
* Simulation Stock

**Flow Navigation** (Screen to Screen)

* Auto-logs in -> Register for a new account if no previous account saved
* Watch-list Stocks -> Takes you to that specific stock detail
* Stock Search -> Opens up list of stocks, searchable, and possibly categorized by price/industry
* Settings -> Toggle settings

## Wireframes
<img src="https://i.imgur.com/5lDpK2D.jpg" width=600>

### [BONUS] Digital Wireframes & Mockups

### [BONUS] Interactive Prototype

## Schema 
### Models
#### Watchlist

   | Property      | Type     | Description |
   | ------------- | -------- | ------------|
   | objectId      | String   | unique id for the user's watchlist (default field) |
   | author        | Pointer to User| watchlist author |
   | symbolsList       | String   | string of symbols seprated by commas |
   | watchCount | Number   | number of symbols that has been added to symbolsList |
   | createdAt     | DateTime | date when watchlist is created (default field) |
   | updatedAt     | DateTime | date when watchlist is last updated (default field) |
### Networking
#### List of network requests by screen
   - Home/Watch-list Screen
      - (Read/GET) Query all stocks where in a user's watch-list
         ```swift
         let query = PFQuery(className:"Watchlist")
         query.whereKey("author", equalTo: currentUser)
		 
         query.findObjectsInBackground { (watchlist: [PFObject]?, error: Error?) in
            if let error = error { 
               print(error.localizedDescription)
            } else if let watchlist = watchlist {
               print("Successfully retrieved watchlist.")
           	// TODO: Parse the string symbolsList by delimiter (,)

            }
         }
         ```
      - (Create/POST) Auto creates a new watchlist for your profile/user
	     ```swift
         let watchlist = PFQuery(className:"Watchlist")
		 watchlist["symbolsList"] = ""
		 watchlist["author"] = PFUser.current()! 
		 watchlist["watchCount"] = 0 
		 
		 watchlist.saveInBackground { (success, error) in
            if success { 
               print("Watchlist created")
            } else {
               print("Error creating watchlist")
            }
         }
         ```
      - (Update/PUT) Delete existing stock on your watchlist
         ```swift
         let query = PFQuery(className:"Watchlist")
         query.whereKey("author", equalTo: currentUser)
		 
		 // Select symbol to be removed could possibly be a button input
		 let toBeRemoved = selectedSymbol 
		 
         query.findObjectsInBackground { (watchlist: [PFObject]?, error: Error?) in
            if let error = error {
               print(error.localizedDescription)
            } else if let watchlist = watchlist {
               print("Successfully retrieved watchlist.")
			
			let watchlistSymbols = query["symbolsList"]
			
           	// TODO: Parse the string symbolsList by delimiter (,) and remove symbol
			// returns: String ---> with updated watchlistSymbols
			
			
			query["symbolsList"] = watchlistSymbols
			query["watchCount"] = query["watchCount"] - 1
			
			watchlist.saveInBackground { (success, error) in
				if success { 
						print("Watchlist saved")
					} else {
						print("Error saving watchlist")
					}
				}
            }
         }
         ```
   - Stock Search Screen
      - (Read/GET) Get various stock objects
		 ```swift
		 let url = URL(String: "https://sandbox.iexapis.com/stable/stock/\(symbol)/chart/1/?token=\(APIKey)")
         let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
		 request.httpMethod = "GET"
         let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
		 let task = session.dataTask(with: request) { (data, response, error) in 
			if let error = error {
				print(error.localizedDescription)
			} else if let data = data {
				let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]]
				
				// TODO: Do something with stock data	
			}
		 }
         ```
   - Settings Screen
      - (Read/GET) Query logged in user object
      - (Update/PUT) Update user password/email
#### [OPTIONAL:] Existing API Endpoints
##### IEX Cloud API
- Base URL - [https://sandbox.iexapis.com/](https://sandbox.iexapis.com/)

   HTTP Verb | Endpoint | Description
   ----------|----------|------------
    `GET`    | /stable/stock/{symbol}/chart/1/?token={token} | return the chart of stock for today
    `GET`    | /stock/{symbol}/batch/?token={token} | get quote, news, chart of symbol
    `GET`    | /search/{fragment}/?token={token} | returns the top 10 matches of the symbol
    `GET`    | /stock/{symbol}/company/?token={token}   | get company of stock
    `GET`    | /stock/{symbol}/price/?token={token} | return price by stock symbol
    
