//
//  TweetCell.swift
//  TwitterClient
//
//  Created by 山口賢登 on 2018/06/02.
//  Copyright © 2018年 山口賢登. All rights reserved.
//

import UIKit

class TweetCell: UICollectionViewCell {

    @IBOutlet weak var tweetTextLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.xibViewSet()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        self.xibViewSet()
    }
    
    internal func xibViewSet() {
        if let view = Bundle.main.loadNibNamed("TweetCell", owner: self, options: nil)?.first as? UIView {
            view.frame = self.bounds
            self.addSubview(view)
        }
    }

}
