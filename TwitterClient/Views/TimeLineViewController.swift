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

class TimeLineViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    fileprivate let viewModel = TimeLineViewModel()
    fileprivate let disposeBag = DisposeBag()
    let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = viewModel
        tableView.refreshControl = refreshControl
        refreshControl.addTarget(viewModel, action: #selector(viewModel.refresh(_:)), for: .valueChanged)
        tableView.addSubview(refreshControl)
        tableView.separatorInset = UIEdgeInsetsMake(50, 100, 50, 0)
        viewModel.checkAccount()
        
        viewModel.items.asObservable().bind(onNext: {_ in
            self.tableView.reloadData()
        })
        .disposed(by: disposeBag)
    }
    
    
}

extension TimeLineViewController: UITableViewDelegate {

}
