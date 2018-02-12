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
    var screenName: String
    var isQuote: Bool
    var timeAgo: String
    
    // MARK: - Create initializer with dictionary
    init(dictionary: [String: Any]) {
        id = dictionary["id"] as! Int64
        text = dictionary["text"] as! String
        
        favoriteCount = dictionary["favorite_count"] as! Int
        favorited = dictionary["favorited"] as! Bool
        retweeted = dictionary["retweeted"] as! Bool
        
        let user = dictionary["user"] as! [String: Any]
        self.user = User(dictionary: user)
        
        if let egg = dictionary["retweeted_status"] {
            isQuote = true
        } else {
            isQuote = false
        }
        profileImageUrl = user["profile_image_url_https"] as! String
        username = user["name"] as! String
        screenName = user["screen_name"] as! String
        retweetCount = dictionary["retweet_count"] as! Int
        
        
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

