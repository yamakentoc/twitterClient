//
//  AccountInformationModel.swift
//  TwitterClient
//
//  Created by 山口賢登 on 2018/05/29.
//  Copyright © 2018年 山口賢登. All rights reserved.
//

import UIKit

struct TweetInformation: Codable {
    //userのプロフ画像
    var image_url: String = ""
    //userの名前
    var name: String = ""
    //userのid
    var scname: String = ""
    //userのツイート文
    var text: String = ""
    //いいねの数
    var favorite_count: Int = 0
    //リツイート数
    var retweet_count: Int = 0
}
