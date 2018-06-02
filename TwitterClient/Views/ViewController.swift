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
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    fileprivate let viewModel = TweetViewModel()
    fileprivate let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = viewModel
        
        viewModel.checkAccount()
        
        viewModel.items.asObservable().bind(onNext: {_ in
            self.collectionView.reloadData()
        })
        .disposed(by: disposeBag)
    }
    
}

extension ViewController: UICollectionViewDelegate {
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let cellWidth:CGFloat = self.view.bounds.width * 0.9
//        let cellHeight: CGFloat = self.view.bounds.height * 0.1
//        return CGSize(width: cellWidth, height: cellHeight)
//    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 15, left: 0, bottom: 15, right: 0)
    }
}
