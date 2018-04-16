//
//  TweetDetailViewController.swift
//  twitter_alamofire_demo
//
//  Created by Brendan Raftery on 2/14/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit
import ActiveLabel

class TweetDetailViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var tweetLabel: ActiveLabel!
    @IBOutlet weak var rtCountLabel: UILabel!
    @IBOutlet weak var favCountLabel: UILabel!
    @IBOutlet weak var retweetByLabel: UILabel!
    @IBOutlet weak var timeAgoLabel: UILabel!
    
    @IBOutlet weak var verifiedImage: UIImageView!
    @IBOutlet weak var rtSubImage: UIImageView!
    @IBOutlet weak var rtSubBackImage: UIImageView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var profileImageBack: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var rtButton: UIButton!
    @IBOutlet weak var favButton: UIButton!
    @IBOutlet weak var followButton: UIButton!
    @IBOutlet weak var replyButton: UIButton!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var tweet: Tweet!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //hideAll()
        
        let tBlue = UIColor(red: 43/255, green: 166/255, blue: 209/255, alpha: 1)
        
        //activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = tBlue
        
        var transform = CGAffineTransform(scaleX: 3.0, y: 3.0)
        activityIndicator.transform = transform;
        
        tweetLabel.enabledTypes = [.url, .hashtag, .mention]
        if (tweet.rawText == "") {
            tweetLabel.text = tweet.text
        } else {
            tweetLabel.text = tweet.rawText
        }
        
        dateLabel.text = "Posted \(tweet.createdAtString)"
        tweetLabel.hashtagColor = tBlue
        tweetLabel.mentionColor = UIColor.lightGray
        tweetLabel.URLSelectedColor = UIColor.white
        tweetLabel.URLColor = tBlue
        timeAgoLabel.text = "• \(tweet.timeAgo)"
        tweetLabel.handleURLTap { message in UIApplication.shared.open(message, options: [:], completionHandler: {
            (success) in
            
        })
        }
        
        nameLabel.text = tweet.username
        usernameLabel.text = "@\(tweet.screenName)"
        
        let purl = URL(string: tweet.profileImageUrl)!
        profileImage.af_setImage(withURL: purl)
        profileImage.layer.cornerRadius = profileImage.frame.height/2
        profileImage.clipsToBounds = true
        profileImageBack.layer.cornerRadius = profileImageBack.frame.height/2
        profileImageBack.clipsToBounds = true
        rtSubImage.layer.cornerRadius = rtSubImage.frame.height/2
        rtSubImage.clipsToBounds = true
        rtSubBackImage.layer.cornerRadius = rtSubBackImage.frame.height/2
        rtSubBackImage.clipsToBounds = true
        
        if (tweet.isQuote) {
            rtSubImage.isHidden = false
            let subUrl = URL(string: tweet.subProfileUrl)!
            rtSubImage.af_setImage(withURL: subUrl)
            rtSubBackImage.isHidden = false
            retweetByLabel.text = "@\(tweet.subUserName) retweeted"
            
        } else {
            rtSubImage.isHidden = true
            rtSubImage.image = nil
            rtSubBackImage.isHidden = true
            retweetByLabel.text = ""
        }
        
        if (tweet.verified) {
            verifiedImage.image = #imageLiteral(resourceName: "verified")
        } else {
            verifiedImage.image = nil
            verifiedImage.frame = verifiedImage.frame.offsetBy(dx: 15, dy: 0)
        }
        
        rtButton.imageView?.contentMode = UIViewContentMode.scaleAspectFit
        favButton.imageView?.contentMode = UIViewContentMode.scaleAspectFit
        
        if (tweet.retweeted == true) {
            if (tweet.retweetCount == 0) {
                tweet.retweetCount = 1
            }
            rtButton.imageView?.image = #imageLiteral(resourceName: "retweet_blue")
        } else {
            rtButton.imageView?.image = #imageLiteral(resourceName: "retweet_grey")
        }
        
        if (tweet.favorited == true) {
            if (tweet.favoriteCount == 0) {
                tweet.favoriteCount = 1
            }
            
            favButton.setImage(#imageLiteral(resourceName: "favorite_red"), for: UIControlState.normal)
            
        } else {
            favButton.setImage(#imageLiteral(resourceName: "favorite_grey"), for: UIControlState.normal)
        }
        
        rtCountLabel.text = "\(tweet.retweetCount)"
        favCountLabel.text = "\(tweet.favoriteCount)"
    
        followButton.layer.cornerRadius = followButton.frame.height/2
        followButton.layer.masksToBounds = true
        
        replyButton.layer.cornerRadius = replyButton.frame.height/2
        replyButton.layer.masksToBounds = true

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Locate Twitter Follow Button
        let maxX = max(self.nameLabel.frame.minX + self.nameLabel.frame.width, self.timeAgoLabel.frame.minX + self.timeAgoLabel.frame.width)
        let y = self.followButton.frame.minY
        let width = self.followButton.frame.width
        let height = self.followButton.frame.height
        
        UIView.animate(withDuration: 0.5, delay: 0, options: .transitionFlipFromRight, animations: {
            print("ANIMATION")
            self.followButton.frame = CGRect(x: maxX + width + 20, y: y, width: width, height: height)
        }, completion: nil)
        
        UIView.animate(withDuration: 0.5, delay: 0, options: .transitionFlipFromRight, animations: {
            print("ANIMATION")
            self.replyButton.frame = CGRect(x: self.view.frame.width/2-self.replyButton.frame.width/2, y: self.replyButton.frame.minY, width: self.replyButton.frame.width, height: self.replyButton.frame.height)
        }, completion: nil)
        
        //unhideAll()
        activityIndicator.stopAnimating()        //animations(flip:UIDevice.current.orientation.isPortrait)
    }
    
    func hideAll() {
        for v in self.view.subviews {
            v.isHidden = true
        }
        activityIndicator.isHidden = false
    }
    
    func unhideAll() {
        for v in self.view.subviews {
            v.isHidden = false
        }
        
        if (tweet.isQuote) {
            rtSubImage.isHidden = false
            let subUrl = URL(string: tweet.subProfileUrl)!
            rtSubImage.af_setImage(withURL: subUrl)
            rtSubBackImage.isHidden = false
            retweetByLabel.text = "@\(tweet.subUserName) retweeted"
            
        } else {
            rtSubImage.isHidden = true
            rtSubImage.image = nil
            rtSubBackImage.isHidden = true
            retweetByLabel.text = ""
        }
        
        if (tweet.verified) {
            verifiedImage.image = #imageLiteral(resourceName: "verified")
        } else {
            verifiedImage.image = nil
            verifiedImage.frame = verifiedImage.frame.offsetBy(dx: 15, dy: 0)
        }
    }
    
    func animations(flip:Bool) {
        
        if (flip) { // GOING TO PORTRAIT
            if (!tweet.verified) {
                UIView.animate(withDuration: 0,  animations: {
                    print("ANIMATION")
                    self.nameLabel.frame = CGRect(x: self.nameLabel.frame.minX, y: self.nameLabel.frame.minY, width: self.nameLabel.frame.width+30, height: self.nameLabel.frame.height)
                }, completion: nil)
            }
        } else {  // GOING TO LANDSCAPE
            
        }
    }
    
    @IBAction func didHitFollow(_ sender: UIButton) {
        sender.pulsate()
    }
    
    @IBAction func didHitFavorite(_ sender: UIButton) {
        sender.pulsate()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        if UIDevice.current.orientation.isLandscape {
            animations(flip: true)
        } else {
            animations(flip: false)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
