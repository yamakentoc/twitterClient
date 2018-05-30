//
//  TweetViewModel.swift
//  
//
//  Created by 山口賢登 on 2018/05/29.
//

import UIKit
import RxSwift

class TweetViewModel: NSObject {
    
    var items = Variable<[String]>([])
    
    override init() {
       items.value.append("hoge")
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
