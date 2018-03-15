//
//  SongTableHeader.swift
//  WangyiMusicPlayer
//
//  Created by yuting jiang on 2018/3/2.
//  Copyright © 2018年 yuting jiang. All rights reserved.
//

import LBTAComponents

class SongTableHeader: DatasourceCell {
    var wg_imageView = "wg_imageView"
    var wg_blueView = "wg_blueView"
    
    let bgImgView: UIImageView = {
        let imgView = UIImageView()
        imgView.backgroundColor = .black
        //imgView.frame =
        return imgView
    }()
    
    let blueEffect = UIBlurEffect(style: .dark)
    let blueEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .light))
    
    let collectButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "collect26"), for: .normal)
        return button
    }()
    
    let commentButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "comment32"), for: .normal)
        return button
    }()
    
    let shareButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "share50"), for: .normal)
        return button
    }()
    
    let downloadButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "download26"), for: .normal)
        return button
    }()
    
    let collectLabel: UILabel = {
        let label = UILabel()
        label.text = "收藏"
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = .white
        return label
    }()
    
    let commentLabel: UILabel = {
        let label = UILabel()
        label.text = "评论"
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = .white
        return label
    }()
    
    let shareLabel: UILabel = {
        let label = UILabel()
        label.text = "分享"
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = .white
        return label
    }()
    
    let downloadLabel: UILabel = {
        let label = UILabel()
        label.text = "下载"
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = .white
        return label
    }()
    
    let albumImgView: UIImageView = {
        let imgView = UIImageView()
        imgView.backgroundColor = .green
        return imgView
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.text = AlbumDetail.albumName
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()
    
    let accountLabel: UIButton = {
        let button = UIButton()
        button.backgroundColor = .black
        button.setImage(#imageLiteral(resourceName: "account"), for: .normal)
        button.setTitle("  Accont >", for: .normal)
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    override func setupViews() {
        blueEffectView.contentMode = .scaleAspectFill
        
        addSubview(bgImgView)
        addSubview(blueEffectView)
        addSubview(albumImgView)
        addSubview(nameLabel)
        //addSubview(accountLabel)
        
        bgImgView.anchor(topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: -400, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: UIScreen.main.bounds.width, heightConstant: 0)
        blueEffectView.anchor(topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: -400, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: UIScreen.main.bounds.width, heightConstant: 0)
        albumImgView.anchor(topAnchor, left: leftAnchor, bottom: nil, right: nil, topConstant: 15, leftConstant: 20, bottomConstant: 0, rightConstant: 0, widthConstant: 150, heightConstant: 150)
        nameLabel.anchor(topAnchor, left: albumImgView.rightAnchor, bottom: nil, right: rightAnchor, topConstant: 25, leftConstant: 15, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 20)
        //accountLabel.anchor(nameLabel.bottomAnchor, left: nameLabel.leftAnchor, bottom: nil, right: rightAnchor, topConstant: 15, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 40)
        
        let url = URL(string:  AlbumDetail.albumCoverImgUrl)
        let data = try? Data(contentsOf: url!)
        if let imageData = data {
            let image = UIImage(data: imageData)
            albumImgView.image = image
            //bgImgView.image = image
        }
        
//        objc_setAssociatedObject(self, &wg_imageView, bgImgView, .OBJC_ASSOCIATION_RETAIN)
//        objc_setAssociatedObject(self, &wg_blueView, blueEffectView, .OBJC_ASSOCIATION_RETAIN)
//
//        self.addObserver(self, forKeyPath: "contentOffset", options: .new, context: nil)

        
        setupButtomButtons()
    }
    
    fileprivate func setupButtomButtons() {
        let collectButtonView = UIView()
        collectButtonView.backgroundColor = .clear
        
        let commentButtonView = UIView()
        commentButtonView.backgroundColor = .clear
        
        let shareButtonView = UIView()
        shareButtonView.backgroundColor = .clear
        
        let downloadButtonView = UIView()
        downloadButtonView.backgroundColor = .clear
        
        let buttonStackView = UIStackView(arrangedSubviews:[collectButtonView, commentButtonView, shareButtonView, downloadButtonView])
        
        buttonStackView.axis = .horizontal
        buttonStackView.distribution = .fillEqually
        
        addSubview(buttonStackView)
        buttonStackView.anchor(nil, left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 60)
        
        addSubview(collectButton)
        collectButton.snp.makeConstraints { (make) in
            make.width.equalTo(23)
            make.height.equalTo(23)
            make.centerX.equalTo(collectButtonView)
            make.centerY.equalTo(collectButtonView).offset(-8)
        }
        
        addSubview(collectLabel)
        collectLabel.snp.makeConstraints { (make) in
            make.width.equalTo(40)
            make.height.equalTo(20)
            make.centerX.equalTo(collectButtonView).offset(7)
            make.centerY.equalTo(collectButtonView).offset(13)
        }
        
        addSubview(commentButton)
        commentButton.snp.makeConstraints { (make) in
            make.width.equalTo(23)
            make.height.equalTo(23)
            make.centerX.equalTo(commentButtonView)
            make.centerY.equalTo(commentButtonView).offset(-8)
        }
        
        addSubview(commentLabel)
        commentLabel.snp.makeConstraints { (make) in
            make.width.equalTo(40)
            make.height.equalTo(20)
            make.centerX.equalTo(commentButtonView).offset(7)
            make.centerY.equalTo(commentButtonView).offset(13)
        }
        
        addSubview(shareButton)
        shareButton.snp.makeConstraints { (make) in
            make.width.equalTo(23)
            make.height.equalTo(23)
            make.centerX.equalTo(shareButtonView)
            make.centerY.equalTo(shareButtonView).offset(-10)
        }
        
        addSubview(shareLabel)
        shareLabel.snp.makeConstraints { (make) in
            make.width.equalTo(40)
            make.height.equalTo(20)
            make.centerX.equalTo(shareButtonView).offset(7)
            make.centerY.equalTo(shareButtonView).offset(13)
        }
        
        
        addSubview(downloadButton)
        downloadButton.snp.makeConstraints { (make) in
            make.width.equalTo(23)
            make.height.equalTo(23)
            make.centerX.equalTo(downloadButtonView)
            make.centerY.equalTo(downloadButtonView).offset(-8)
        }
        
        addSubview(downloadLabel)
        downloadLabel.snp.makeConstraints { (make) in
            make.width.equalTo(40)
            make.height.equalTo(20)
            make.centerX.equalTo(downloadButtonView).offset(7)
            make.centerY.equalTo(downloadButtonView).offset(13)
        }
    }
}

