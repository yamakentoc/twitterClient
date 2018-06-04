//
//  ViewController.swift
//  TwitterClient
//
//  Created by 山口賢登 on 2018/05/28.
//  Copyright © 2018年 山口賢登. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    fileprivate let viewModel = TweetViewModel()
    fileprivate let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = viewModel
        viewModel.checkAccount()
        
        viewModel.items.asObservable().bind(onNext: {_ in
            self.tableView.reloadData()
        })
        .disposed(by: disposeBag)
    }
    
}

extension ViewController: UITableViewDelegate {

}
