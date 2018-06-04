//
//  TweetCell.swift
//  TwitterClient
//
//  Created by 山口賢登 on 2018/06/02.
//  Copyright © 2018年 山口賢登. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {
    
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userID: UILabel!
    @IBOutlet weak var userIcon: UIImageView!
    @IBOutlet weak var tweetText: UILabel!
    @IBOutlet weak var backView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.xibViewSet()
    }
    
    internal func xibViewSet() {
        userIcon.layer.masksToBounds = true
        backView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMinYCorner]
        backView.layer.masksToBounds = false
        backView.layer.masksToBounds = false
        backView.layer.cornerRadius  = 12
        backView.layer.shadowOffset = CGSize(width: 0, height: 3)
        backView.layer.shadowOpacity = 0.4
        backView.layer.shadowRadius = 5

        backView.layer.shouldRasterize = true
        backView.layer.rasterizationScale = UIScreen.main.scale
    }
    
    
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        backView.layer.cornerRadius = 15
        userIcon.layer.cornerRadius = userIcon.bounds.width / 2
    }
    
}
