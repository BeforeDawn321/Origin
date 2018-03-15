//
//  SetupLyricView.swift
//  WangyiMusicPlayer
//
//  Created by yuting jiang on 2018/3/8.
//  Copyright © 2018年 yuting jiang. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation
import MediaPlayer

extension PlayerViewController {
    func setUpScrollerView(frame : CGRect) {
        lrcScrollView.contentSize = CGSize(width: frame.width * 2, height: 0)
    }
    
//    func addLrcView() {
//        lrcVC.tableView.backgroundColor = UIColor.clear
//        lrcScrollView.addSubview(lrcVC.tableView)
//        lrcScrollView.isPagingEnabled = true
//        lrcScrollView.showsHorizontalScrollIndicator = false
//        lrcScrollView.delegate = self as! UIScrollViewDelegate
//    }
//    
//    func setUpLrcView() {
//        let frame = lrcScrollView.bounds
//        lrcVC.tableView.frame = frame
//        lrcVC.tableView.x = frame.width
//        self.setUpScrollerView(frame: frame)
//        self.setUpImageView()
//    }
//    
    func setUpImageView() {
        imageView.backgroundColor = .clear
        imageView.image = nil
        disk.backgroundColor = .clear
        disk.image = nil
    }
}
