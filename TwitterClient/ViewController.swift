//
//  ViewController.swift
//  TwitterClient
//
//  Created by 山口賢登 on 2018/05/28.
//  Copyright © 2018年 山口賢登. All rights reserved.
//

import UIKit
import TwitterKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        if let session = TWTRTwitter.sharedInstance().sessionStore.session() {
            print(session.userID)
        } else {
            print("アカウントはありません")
        }
        
        
        TWTRTwitter.sharedInstance().logIn { session, error in
            guard let session = session else {
                if let error = error {
                    print("エラーが起きました => \(error.localizedDescription)")
                }
                return
            }
            print("@\(session.userName)でログインしました")
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func tapTweet(_ sender: Any) {
        TWTRComposer().show(from: self) { _ in }
    }
    
}

