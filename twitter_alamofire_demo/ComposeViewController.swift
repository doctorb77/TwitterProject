//
//  ComposeViewController.swift
//  twitter_alamofire_demo
//
//  Created by Brendan Raftery on 4/15/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit

protocol ComposeViewControllerDelegate {
    func did(post: Tweet)
}

class ComposeViewController: UIViewController, ComposeViewControllerDelegate, UITextViewDelegate {
    
    func did(post: Tweet) {
        
    }
    
    @IBOutlet weak var characters: UILabel!
    @IBOutlet weak var tweetTextView: UITextView!
    @IBOutlet weak var postButton: UIButton!
    var delegate: ComposeViewControllerDelegate?
    var tweetTooLong: Bool = false
    var replying: Bool = false
    var replyId: String?
    var newPlaceholder: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let currentText = tweetTextView.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: text)
        characters.text = String(Int(140 - updatedText.count))
        
        if (updatedText.count < 5) {
            characters.textColor = UIColor.red
        } else {
            characters.textColor = UIColor.white
        }
        
        return updatedText.count < 140 // Change limit based on your requirement.
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didPost(_ sender: Any) {
        if tweetTextView.text.count == 0 || tweetTextView.text.count > 140  {
            print("Tweet too long!")
        }
        
        if !replying {
            APIManager.shared.composeTweet(with: tweetTextView.text) { (tweet, error) in
                if let error = error {
                    print("Error composing Tweet: \(error.localizedDescription)")
                    self.dismiss(animated: true, completion: nil)
                } else if let tweet = tweet {
                    self.delegate?.did(post: tweet)
                    print("Compose Tweet Success!")
                    self.dismiss(animated: true, completion: nil)
                }
            }
        } else if let id = replyId {
            
            APIManager.shared.reply(id: id, text: tweetTextView.text, completion: {(tweet, error) in
                if let error = error {
                    print("Error replying to Tweet: \(error.localizedDescription)")
                    self.dismiss(animated: true, completion: nil)
                } else if tweet != nil {
                    self.dismiss(animated: true, completion: nil)
                    print("Reply to tweet successful")
                }
            })
            
            // Reset reply variables
            replying = false
            replyId = nil
            newPlaceholder = nil
        }
    }

    
}
