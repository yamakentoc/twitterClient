//
//  TweetViewModel.swift
//  
//
//  Created by 山口賢登 on 2018/05/29.
//

import UIKit
import RxSwift
import TwitterKit
import SwiftyJSON
import AlamofireImage

class TimeLineViewModel: NSObject {
    
    var items = Variable<[TweetInformation]>([])
    var tweetInfo: [TweetInformation] = []
    
    override init() {
        
    }
    func checkAccount() {
        if let session = TWTRTwitter.sharedInstance().sessionStore.session() {
            getTL(userID: session.userID, refresh: false)
        } else {
            TWTRTwitter.sharedInstance().logIn { session, error in
                guard let session = session else {
                    if let error = error {
                        print("エラーが起きました => \(error.localizedDescription)")
                    }
                    return
                }
                print("@\(session.userName)でログインしました")
                self.getTL(userID: session.userID, refresh: false)
            }
        }
    }
    
    func getTL(userID: String, refresh: Bool) {
        var clientError: NSError?
        let client = TWTRAPIClient.withCurrentUser()
        let URLEndpoint = "https://api.twitter.com/1.1/statuses///home_timeline.json"//user_timeline.json"
        let params = ["user_id":userID ,"count": "100"]
        
        let request = client.urlRequest (
            withMethod: "GET",
            urlString: URLEndpoint,
            parameters: params,
            error: &clientError
        )
        client.sendTwitterRequest(request) { (response, data, connectionError) -> Void in
            if connectionError != nil {
                print("error: \(String(describing: connectionError))")
                return
            }
            if let data = data {
                do {
                    refresh == true ? self.items.value.removeAll() : nil
                    var json = try JSON(data: data)
                    print("json--\(json)")
                    for i in (0..<json.count){
                        var getInfo = TweetInformation()
                        if json[i]["user"]["profile_image_url"].string != nil{
                            getInfo.image_url = json[i]["user"]["profile_image_url"].string!
                        }
                        if json[i]["user"]["name"].string != nil{
                            getInfo.name = json[i]["user"]["name"].string!
                        }
                        if json[i]["user"]["screen_name"].string != nil{
                            getInfo.scname = json[i]["user"]["screen_name"].string!
                        }
                        if json[i]["text"].string != nil{
                            getInfo.text = json[i]["text"].string!
                        }
                        if json[i]["favorite_count"].int != nil{
                            getInfo.favorite_count = json[i]["favorite_count"].int!
                        }
                        if json[i]["retweet_count"].int != nil{
                            getInfo.retweet_count = json[i]["retweet_count"].int!
                        }
                        if json[i]["entities"]["media"][0]["media_url"].string != nil {
                            getInfo.media_url = json[i]["entities"]["media"][0]["media_url"].string!
                        }
                        self.items.value.append(getInfo)
                    }
                } catch let jsonError as NSError {
                    print("json error: \(jsonError.localizedDescription)")
                }
            }
        }
    }
    
   @objc func refresh(_ sender: UIRefreshControl) {
        if let session = TWTRTwitter.sharedInstance().sessionStore.session() {
            getTL(userID: session.userID, refresh: true)
            refreshControlValueChanged(sender: sender)
        }
    }
    func refreshControlValueChanged(sender: UIRefreshControl) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
            sender.endRefreshing()
        })
    }
    
}

extension TimeLineViewModel: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if items.value[indexPath.row].media_url == "" {
            tableView.register(UINib(nibName: "TweetCell", bundle: nil), forCellReuseIdentifier: "TweetCell")
            let cell = tableView.dequeueReusableCell(withIdentifier: "TweetCell", for: indexPath) as! TweetCell
            cell.configureCell(tweetInfo: items.value[indexPath.row])
            return cell
        } else {
            tableView.register(UINib(nibName: "TweetImageCell", bundle: nil), forCellReuseIdentifier: "TweetImageCell")
            let cell = tableView.dequeueReusableCell(withIdentifier: "TweetImageCell", for: indexPath) as! TweetImageCell
            cell.configureCell(tweetInfo: items.value[indexPath.row])
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        tableView.estimatedRowHeight = 10 //セルの高さ
        return UITableViewAutomaticDimension //自動設定
    }
}
