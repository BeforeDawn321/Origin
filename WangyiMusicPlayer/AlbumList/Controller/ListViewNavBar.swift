
//
//  ListViewNavBar.swift
//  WangyiMusicPlayer
//
//  Created by yuting jiang on 2018/2/19.
//  Copyright © 2018年 yuting jiang. All rights reserved.
//

import UIKit

extension ListViewController {
    func setupNavigationBarItems() {
        navigationController?.navigationBar.barTintColor = UIColor(r: 210, g: 60, b: 60)
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.font:UIFont.boldSystemFont(ofSize: 17), NSAttributedStringKey.foregroundColor:UIColor(r: 255, g: 255, b: 255)]
        
        navigationItem.title = "我的音乐"
        
        
        print(123)
        
    }
}
