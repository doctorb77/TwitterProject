//
//  TweetCell.swift
//  twitter_alamofire_demo
//
//  Created by Charles Hieger on 6/18/17.
//  Copyright © 2017 Charles Hieger. All rights reserved.
//

import UIKit
import AlamofireImage
import ActiveLabel

class TweetCell: UITableViewCell {
    
   // @IBOutlet weak var tweetTextLabel: UILabel!
    
    @IBOutlet weak var newLabel: ActiveLabel!
    @IBOutlet weak var nameTextLabel: UILabel!
    @IBOutlet weak var idTextLabel: UILabel!
    @IBOutlet weak var timeTextLabel: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var rtCountLabel: UILabel!
    @IBOutlet weak var favCountLabel: UILabel!
    @IBOutlet weak var profileBackground: UIImageView!
    @IBOutlet weak var rtImage: UIButton!
    @IBOutlet weak var favImage: UIButton!
    @IBOutlet weak var rtLogo: UIImageView!
    @IBOutlet weak var rtBackground: UIImageView!
    @IBOutlet weak var dateTextLabel: UILabel!
    
    var tweet: Tweet! {
        didSet {
            let tBlue = UIColor(red: 43/255, green: 166/255, blue: 209/255, alpha: 1)
            
            newLabel.enabledTypes = [.url, .hashtag, .mention]
            newLabel.text = tweet.text
            newLabel.hashtagColor = tBlue
            newLabel.mentionColor = UIColor.lightGray
            newLabel.URLSelectedColor = UIColor.white
            newLabel.URLColor = tBlue
            newLabel.handleURLTap { message in UIApplication.shared.open(message, options: [:], completionHandler: {
                (success) in
                
                })
             }
            
            nameTextLabel.text = tweet.username
            dateTextLabel.text = tweet.createdAtString
            timeTextLabel.text = "• \(tweet.timeAgo)"
            idTextLabel.text = "@\(tweet.screenName)"
            let purl = URL(string: tweet.profileImageUrl)!
            profileImage.af_setImage(withURL: purl)
            profileImage.layer.cornerRadius = profileImage.frame.height/2
            profileImage.clipsToBounds = true
            profileBackground.layer.cornerRadius = profileBackground.frame.height/2
            profileBackground.clipsToBounds = true
            rtLogo.layer.cornerRadius = rtLogo.frame.height/2
            rtLogo.clipsToBounds = true
            rtBackground.layer.cornerRadius = rtBackground.frame.height/2
            rtBackground.clipsToBounds = true
        
            if (tweet.isQuote) {
                rtLogo.isHidden = false
                let subUrl = URL(string: tweet.subProfileUrl)!
                rtLogo.af_setImage(withURL: subUrl)
    
                rtBackground.isHidden = false
            } else {

                rtLogo.isHidden = true
                rtLogo.image = nil
                rtBackground.isHidden = true
            }
            
            rtImage.imageView?.contentMode = UIViewContentMode.scaleAspectFit
            favImage.imageView?.contentMode = UIViewContentMode.scaleAspectFit
            
            if (tweet.retweeted == true) {
                if (tweet.retweetCount == 0) {
                    tweet.retweetCount = 1
                }
                rtImage.setImage(#imageLiteral(resourceName: "retweet_blue"), for: UIControlState.normal)
            } else {
                rtImage.setImage(#imageLiteral(resourceName: "retweet_grey"), for: UIControlState.normal)
            }
            
            if (tweet.favorited == true) {
                if (tweet.favoriteCount == 0) {
                    tweet.favoriteCount = 1
                }
        
                favImage.setImage(#imageLiteral(resourceName: "favorite_red"), for: UIControlState.normal)
                
            } else {
                favImage.setImage(#imageLiteral(resourceName: "favorite_grey"), for: UIControlState.normal)
            }
            
            rtCountLabel.text = "\(tweet.retweetCount)"
            favCountLabel.text = "\(tweet.favoriteCount)"
        }
        
        
    }
    
    @IBAction func didTapFavorite(_ sender: UIButton) {
        
        tweet.favorited = !(tweet.favorited)
        
        if (tweet.favorited == true) {
 
            sender.heartBeat()
            
            tweet.favoriteCount = tweet.favoriteCount + 1
            favImage.setImage(#imageLiteral(resourceName: "favorite_red"), for: UIControlState.normal)
            
            APIManager.shared.favorite(tweet) { (tweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error favoriting tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    print("Successfully favorited the following Tweet: \n\(tweet.text)")
                }
            }

        } else {
            tweet.favoriteCount = tweet.favoriteCount - 1
            favImage.setImage(#imageLiteral(resourceName: "favorite_grey"), for: UIControlState.normal)
            
            sender.shake()
            
            APIManager.shared.unfavorite(tweet) { (tweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error unfavoriting tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    print("Successfully unfavorited the following Tweet: \n\(tweet.text)")
                }
            }
        }
        
        favCountLabel.text = "\(tweet.favoriteCount)"
    }

    
    @IBAction func didTapRetweet(_ sender: UIButton) {
        
        tweet.retweeted = !(tweet.retweeted)
        if (tweet.retweeted == true) {
            tweet.retweetCount = tweet.retweetCount + 1
            rtImage.setImage(#imageLiteral(resourceName: "retweet_blue"), for: UIControlState.normal)
            
            sender.flash()
            
            APIManager.shared.retweet(tweet) { (tweet: Tweet?, error: Error?) in
                if let  error = error {
                    //print("Error retweeting tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    //print("Successfully retweeted the following Tweet: \n\(tweet.text)")
                }
            }
            
        } else {
            tweet.retweetCount = tweet.retweetCount - 1
            rtImage.setImage(#imageLiteral(resourceName: "retweet_grey"), for: UIControlState.normal)
            
            sender.shake()
            
            APIManager.shared.unretweet(tweet) { (tweet: Tweet?, error: Error?) in
                if let  error = error {
                    //print("Error unretweeting tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    //print("Successfully unretweeted the following Tweet: \n\(tweet.text)")
                }
            }
        }
        
        rtCountLabel.text = "\(tweet.retweetCount)"
    }
    

    @IBAction func pushFavorite(_ sender: UIButton) {
        //sender.pulsate()
        sender.tintColor = UIColor.red
        didTapFavorite(sender)
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
