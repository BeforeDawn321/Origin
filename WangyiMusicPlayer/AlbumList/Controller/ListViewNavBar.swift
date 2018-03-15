
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
        setupNavTitle()
        setupRightNavBarItem()
    }
    
    func setupNavTitle() {
        navigationController?.navigationBar.barTintColor = UIColor(r: 210, g: 60, b: 60)
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.font:UIFont.boldSystemFont(ofSize: 17), NSAttributedStringKey.foregroundColor:UIColor(r: 255, g: 255, b: 255)]
        navigationController?.navigationBar.tintColor = .white
        navigationItem.backBarButtonItem?.title = ""
        navigationItem.title = "我的音乐"
    }
    
    func setupRightNavBarItem() {
        let accountButton: UIButton = {
            let button = UIButton(
            )
            button.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
            button.imageView?.contentMode = .scaleAspectFit
            button.setImage(#imageLiteral(resourceName: "account"), for: .normal)
            return button
        }()
        
        accountButton.snp.makeConstraints { (make) in
            make.width.equalTo(34)
            make.height.equalTo(34)
        }
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: accountButton)
        accountButton.addTarget(self, action: #selector(toLoginView), for: .touchUpInside)
    }
    
    @objc func toLoginView() {
        let loginViewController = LoginViewController()
        self.present(loginViewController, animated: true, completion: nil)
    }
}
