//
//  TweetViewController.swift
//  TwitterClientTweetViewController
//
//  Created by 山口賢登 on 2018/06/04.
//  Copyright © 2018年 山口賢登. All rights reserved.
//

import UIKit
import TwitterKit

class TweetViewController: UIViewController {

    @IBOutlet weak var tweetButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTweetButton()
    }
    
    func setTweetButton() {
        tweetButton.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMinYCorner]
        tweetButton.layer.cornerRadius = tweetButton.bounds.width/2
        tweetButton.layer.shadowOffset = CGSize(width: 0, height: 5)
        tweetButton.layer.shadowOpacity = 0.4
        tweetButton.layer.shadowRadius = 8
        
        tweetButton.layer.shouldRasterize = true
        tweetButton.layer.rasterizationScale = UIScreen.main.scale
    }
    
    @IBAction func tapTweetButton(_ sender: UIButton) {
        TWTRComposer().show(from: self) { _ in }
    }
    
}
