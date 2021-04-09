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

## Product Spec

### 1. User Stories (Required and Optional)

**Required Must-have Stories**

* User can log in to pick their stocks to be placed on a watch list
* Each user can save their preferences on an account
* User can search and look at detailed stock information
* Settings (General, Dark Mode, Notifications, etc.)

**Optional Nice-to-have Stories**

* User can see the top stock gains/losses that week
* User can invest fake money into different stocks
* User receives real time calculated investment earnings of said fake money
* User can also see crypto-currency exchange

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
[This section will be completed in Unit 9]
### Models
[Add table of models]
### Networking
- [Add list of network requests by screen ]
- [Create basic snippets for each Parse network request]
- [OPTIONAL: List endpoints if using existing API such as Yelp]
