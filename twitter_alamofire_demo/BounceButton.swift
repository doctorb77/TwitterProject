//
//  BounceButton.swift
//  twitter_alamofire_demo
//
//  Created by Brendan Raftery on 2/14/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit

class BounceButton: UIButton {

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        self.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        
        print("IN TOUCHES")
        UIView.animate(withDuration: 4, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 6, options: .allowUserInteraction, animations: {
            self.transform = CGAffineTransform.identity
        }, completion: nil)
        
        /*
        UIView.animate(withDuration: 0.25, delay: 3, options: .allowUserInteraction, animations: {
            self.frame.size.width *= 0.8
            print("FINISH 2")
        }, completion: nil)
        */

    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
