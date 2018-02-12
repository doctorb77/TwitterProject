//
//  TimelineViewController.swift
//  twitter_alamofire_demo
//
//  Created by Charles Hieger on 6/18/17.
//  Copyright © 2017 Charles Hieger. All rights reserved.
//

import UIKit

import AlamofireImage

class TimelineViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {
    
    var tweets: [Tweet] = []
    var isMoreDataLoading: Bool = false
    var profilePic:UIImage = UIImage()
    var profContainer:UIImageView = UIImageView()
    
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var tableView: UITableView!
    static var tvPoint: UITableView = UITableView()
    
    @IBOutlet weak var backImage: UIImageView!
    @IBOutlet weak var BackView: UIView!
    /*
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (!isMoreDataLoading) {
            let scrollViewContentHeight = tableView.contentSize.height
            let scrollOffsetThreshold = scrollViewContentHeight - tableView.bounds.size.height
            
            // When the user has scrolled past the threshold, start requesting
            if(scrollView.contentOffset.y > scrollOffsetThreshold && tableView.isDragging) {
                isMoreDataLoading = true
                
                let scrollViewContentHeight = tableView.contentSize.height
                let scrollOffsetThreshold = scrollViewContentHeight - tableView.bounds.size.height
                
                
                APIManager.shared.getHomeTimeLine(withMaxId: tweets.last?.id) { (tweets, error) in
                    if let tweets = tweets {
                        
                        self.tweets.remove(at: self.tweets.count - 1)
                        self.tweets += tweets
                        self.tableView.reloadData()
                        self.isMoreDataLoading = false
                        

                    } else if let error = error {
                        print(error.localizedDescription)
                    }
                }
                
                self.tableView.reloadData()
            }
        }
    }
 */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tBlue = UIColor(red: 43/255, green: 166/255, blue: 209/255, alpha: 1)
        let tGrey = UIColor(red: 170/255, green: 170/255, blue: 170/255, alpha: 1)
        
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = tBlue
        
        var transform = CGAffineTransform(scaleX: 3.0, y: 3.0)
        activityIndicator.transform = transform;
        
        navigationController?.navigationBar.barTintColor = tBlue
        navigationController?.navigationBar.titleTextAttributes =  [NSForegroundColorAttributeName: UIColor.white]
        
        navigationController?.navigationBar.tintColor = UIColor.white
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshControlAction(_:)), for: UIControlEvents.valueChanged)

        tableView.insertSubview(refreshControl, at: 0)
        tableView.dataSource = self
        tableView.delegate = self
        TimelineViewController.tvPoint = tableView
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100
        
        APIManager.shared.getHomeTimeLine { (tweets, error) in
            if let tweets = tweets {
                self.tweets = tweets
                self.tableView.reloadData()
            } else if let error = error {
                print("Error getting home timeline: " + error.localizedDescription)
            }
        }
        
        APIManager.shared.getCurrentAccount{ (user, error) in
            if error != nil {
                
            } else if let user = user {
                
                print("TOMATO")
                var profUrl = user.dictionary!["profile_image_url_https"] as! String
                profUrl = profUrl.replacingOccurrences(of: "_normal", with: "")
                print(profUrl)
                let actUrl = URL(string: profUrl)!
                self.profContainer.af_setImage(withURL: actUrl)
                
                let data = try! Data(contentsOf: actUrl)
                self.profilePic = UIImage(data: data, scale: UIScreen.main.scale)!
                
                /*
                self.navigationController?.navigationBar.backIndicatorImage = uiv.image
                self.barItem.setBackgroundImage(<#T##backgroundImage: UIImage?##UIImage?#>, for: <#T##UIControlState#>, barMetrics: <#T##UIBarMetrics#>)
                */
                self.title = user.screenName
                
                //create a new button
                let button = UIButton()
                button.frame = CGRect(x: 0,y: 0,width: 40,height: 40)
                
                let image = self.profilePic
                
                UIGraphicsBeginImageContextWithOptions(button.frame.size, false, image.scale)
                let rect  = CGRect(x: 0,y: 0,width: button.frame.size.width,height: button.frame.size.height)
                UIBezierPath(roundedRect: rect, cornerRadius: rect.width/2).addClip()
                image.draw(in: rect)
                
                let newImage = UIGraphicsGetImageFromCurrentImageContext()
                UIGraphicsEndImageContext()
                
                
                let color = UIColor(patternImage: newImage!)
                button.backgroundColor = color
                button.layer.cornerRadius = 0.5 * button.bounds.size.width
                let barButton = UIBarButtonItem()
                barButton.customView = button
        //      self.navigationItem.rightBarButtonItem = barButton
                
    /*
                //set frame
                button.frame = CGRect(x: 50, y: 0, width: 40, height: 40)
                button.imageView?.contentMode = UIViewContentMode.scaleAspectFit
                button.imageView?.layer.cornerRadius = (button.imageView?.frame.height)!/2
                button.imageView?.clipsToBounds = true
 
 
                //assign button to navigationbar
    */
 
                self.navigationItem.leftBarButtonItem = barButton
            
                print(user.dictionary!["profile_banner_url"])
                
                if let bannerUrlString = user.dictionary!["profile_banner_url"] as? String {
                    let actUrl = URL(string: bannerUrlString)!
                    self.backImage.af_setImage(withURL: actUrl)
                    self.backImage.contentMode = UIViewContentMode.scaleAspectFill
                }
                
                print("BANANA")
                
            }
        }
    }
    
    func refreshControlAction(_ refreshControl: UIRefreshControl) {
        
        APIManager.shared.getHomeTimeLine { (tweets, error) in
            if let tweets = tweets {
                self.tweets = tweets
                self.tableView.reloadData()
            } else if let error = error {
                print("Error getting home timeline: " + error.localizedDescription)
            }
        }
        refreshControl.backgroundColor = UIColor.clear
        refreshControl.endRefreshing()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TweetCell", for: indexPath) as! TweetCell
        
        cell.tweet = tweets[indexPath.row]
        
        activityIndicator.stopAnimating()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func didTapLogout(_ sender: Any) {
        APIManager.logout()
    }
    
    @IBAction func didPushFavorite(_ sender: Any) {
        tableView.reloadData()
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
