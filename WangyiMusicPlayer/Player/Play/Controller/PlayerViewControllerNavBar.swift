//
//  PlayerViewControllerNavBar.swift
//  WangyiMusicPlayer
//
//  Created by yuting jiang on 2018/3/5.
//  Copyright © 2018年 yuting jiang. All rights reserved.
//

import Foundation
import UIKit

extension PlayerViewController {
    func setNavBar() {
        let commentButton: UIButton = {
            let button = UIButton()
            button.setImage(#imageLiteral(resourceName: "comment32"), for: .normal)
            return button
        }()
        commentButton.snp.makeConstraints { (make) in
            make.width.equalTo(32)
            make.height.equalTo(32)
        }
        
        commentButton.addTarget(PlayerViewController(), action: #selector(commentButtonTapped(sender:)), for: .touchUpInside)
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: commentButton)
        navigationItem.title = Song.songArray[PlayerViewController.queue].title
    }

    func addBackBtn(){
        
        let leftBtn:UIBarButtonItem=UIBarButtonItem(title: "返回", style: UIBarButtonItemStyle.plain, target: self, action: Selector(("actionBack")))
        
        leftBtn.title="返回";
        
        leftBtn.tintColor = UIColor.white;
        
        self.navigationItem.leftBarButtonItem = leftBtn;
        
    }
    
    //返回按钮事件
    
    func actionBack() {
        let songTableViewController = SongTableViewController()
        self.navigationController?.pushViewController(songTableViewController, animated: true)
        //audioPlayer.pause()
        //self.navigationController?.popToViewController(songTableViewController, animated: true)
    }
}
