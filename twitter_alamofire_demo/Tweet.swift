//
//  Tweet.swift
//  twitter_alamofire_demo
//
//  Created by Charles Hieger on 6/18/17.
//  Copyright © 2017 Charles Hieger. All rights reserved.
//

import Foundation

import DateToolsSwift

class Tweet {
    
    // MARK: Properties
    var id: Int64 // For favoriting, retweeting & replying
    var text: String // Text content of tweet
    var favoriteCount: Int // Update favorite count label
    var favorited: Bool // Configure favorite button
    var retweetCount: Int // Update favorite count label
    var retweeted: Bool // Configure retweet button
    var user: User // Contains name, screenname, etc. of tweet author
    var username: String
    var createdAtString: String // Display date
    var profileImageUrl: String
    var subProfileUrl: String
    var screenName: String
    var isQuote: Bool
    var timeAgo: String
    var following: Bool
    var subUserName: String
    var subName: String
    var rawText: String
    var verified: Bool
    
    var retweetedByUser: User?
    
    // MARK: - Create initializer with dictionary
    init(dictionary: [String: Any]) {
        id = dictionary["id"] as! Int64
        /*
        text = ""
        if let text = dictionary["full_text"] as? String {
            
        } else {
            text = dictionary["text"] as! String
        }
        */
        
        var dictionary = dictionary
        subProfileUrl = ""
        subName = ""
        subUserName = ""
        rawText = ""
        if let origin = dictionary["retweeted_status"] as? [String: Any] {
            let userDictionary = dictionary["user"] as! [String: Any]
            self.retweetedByUser = User(dictionary: userDictionary)
            
            dictionary = origin
            
            rawText = dictionary["full_text"] as! String
            
            dictionary["full_text"] = "Retweeted by @" + (userDictionary["screen_name"] as! String + ":\n" + (dictionary["full_text"] as! String))
        
            
            print("BABBLE")
            print(rawText)
            print("PORTABLES")
            subProfileUrl = userDictionary["profile_image_url_https"] as! String
            subProfileUrl = subProfileUrl.replacingOccurrences(of: "_normal", with: "")
            subName = userDictionary["name"] as! String
            subUserName = userDictionary["screen_name"] as! String
        }
       
        text = dictionary["full_text"] as! String
        favoriteCount = dictionary["favorite_count"] as! Int
        favorited = dictionary["favorited"] as! Bool
        retweeted = dictionary["retweeted"] as! Bool
        
        let user = dictionary["user"] as! [String: Any]
        self.user = User(dictionary: user)
        
        if (subProfileUrl != "") {
            isQuote = true
        } else {
            isQuote = false
        }
        profileImageUrl = user["profile_image_url_https"] as! String
        profileImageUrl = profileImageUrl.replacingOccurrences(of: "_normal", with: "")
        username = user["name"] as! String
        screenName = user["screen_name"] as! String
        retweetCount = dictionary["retweet_count"] as! Int
        following = user["following"] as! Bool
        verified = user["verified"] as! Bool
        
        let createdAtOriginalString = dictionary["created_at"] as! String
        let formatter = DateFormatter()
        // Configure the input format to parse the date string
        formatter.dateFormat = "E MMM d HH:mm:ss Z y"
        // Convert String to Date
        let date = formatter.date(from: createdAtOriginalString)!
        // Configure output format
        formatter.dateStyle = .short
        formatter.timeStyle = .none
        // Convert Date to String
        createdAtString = formatter.string(from: date)
        
        let ta = 2.seconds.earlier(than: date)
        timeAgo = String(describing: ta.shortTimeAgoSinceNow)
        
        
        // GET https://api.twitter.com/1.1/statuses/show.json?id=210462857140252672
        
        
    }
    
    static func tweets(with array: [[String: Any]]) -> [Tweet] {
        var tweets: [Tweet] = []
        for tweetDictionary in array {
            let tweet = Tweet(dictionary: tweetDictionary)
            tweets.append(tweet)
        }
        return tweets
    }
}

