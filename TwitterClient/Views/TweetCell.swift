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
//        if let view = Bundle.main.loadNibNamed("TweetCell", owner: self, options: nil)?.first as? UIView {
//            view.frame = self.bounds
//            view.backgroundColor = .clear
            userIcon.layer.masksToBounds = true
            backView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMinYCorner]
            contentView.layer.masksToBounds = false
            layer.masksToBounds = false
            
            layer.cornerRadius  = 12
            layer.shadowOffset = CGSize(width: 0, height: 2)
            layer.shadowOpacity = 0.15
            layer.shadowRadius = 12
            
            layer.shouldRasterize = true
            layer.rasterizationScale = UIScreen.main.scale
            //self.addSubview(view)
    //    }
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        backView.layer.cornerRadius = 12
        userIcon.layer.cornerRadius = userIcon.bounds.width / 2
    }

}
