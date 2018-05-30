//
//  TweetViewModel.swift
//  
//
//  Created by 山口賢登 on 2018/05/29.
//

import UIKit
import RxSwift
import TwitterKit

class TweetViewModel: NSObject {
    
    var items = Variable<[String]>([])
    
    override init() {
       items.value.append("hoge")
    }
    
    func checkAccount() {
//        if let session = TWTRTwitter.sharedInstance().sessionStore.session() {
//            print(session.userID)
//            self.getTL(session: session as! TWTRSession)
//        } else {
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
       // }
    }
    
    func getTL(session: TWTRSession) {
        var clientError: NSError?
        let client = TWTRAPIClient.withCurrentUser()
        let URLEndpoint = "https://api.twitter.com/1.1/statuses/user_timeline.json"
        let params = ["user_id":session.userID,"count": "1"]
        let request = client.urlRequest (
            withMethod: "GET",
            urlString: URLEndpoint,
            parameters: params,
            error: &clientError
        )
        
        client.sendTwitterRequest(request) {(response, data, connectionError) -> Void in
            if connectionError != nil {
                print("error: \(String(describing: connectionError))")
                return
            }
            if let data = data, let json = String(data: data, encoding: .utf8) {
                print("----\n\(json)")
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
         cell.textLabel?.text = items.value[indexPath.row]
        return cell
    }
    
    
}
