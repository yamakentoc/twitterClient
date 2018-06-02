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

class TweetViewModel: NSObject {
    
    var items = Variable<[TweetInformation]>([])
    var tweetInfo: [TweetInformation] = []
    
    override init() {
       
    }
    
    func checkAccount() {
        TWTRTwitter.sharedInstance().logIn { session, error in
            guard let session = session else {
                if let error = error {
                    print("エラーが起きました => \(error.localizedDescription)")
                }
                return
            }
            print("@\(session.userName)でログインしました")
            self.getTL(session: session)
        }
    }
    
    func getTL(session: TWTRSession) {
        var clientError: NSError?
        let client = TWTRAPIClient.withCurrentUser()
        let URLEndpoint = "https://api.twitter.com/1.1/statuses///home_timeline.json"//user_timeline.json"
        let params = ["user_id":session.userID,"count": "100"]
        
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
                    var json = try JSON(data: data)
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
                        self.items.value.append(getInfo)
                    }
                } catch let jsonError as NSError {
                    print("json error: \(jsonError.localizedDescription)")
                }
            }
        }
    }
}

extension TweetViewModel: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = items.value[indexPath.row].text
        return cell
    }
}
