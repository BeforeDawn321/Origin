//
//  ListCell.swift
//  WangyiMusicPlayer
//
//  Created by yuting jiang on 2018/2/19.
//  Copyright © 2018年 yuting jiang. All rights reserved.
//

import LBTAComponents

class ListCell: DatasourceCell {
    
    override var datasourceItem: Any? {
        didSet {
            guard let playlist = datasourceItem as? Playlist else { return }
            let name = playlist.name
            let trackCount = "\(playlist.trackCount)"
            
            albumNameLabel.text = name
            dowloadedNumLabel.text = "\(trackCount)首 已下载"
            let url = URL(string: playlist.coverImgUrl)
            let data = try? Data(contentsOf: url!)
            
            if let imageData = data {
                let image = UIImage(data: imageData)
                albumImgView.image = image
            }
            
        }
    }
    
    let albumImgView: UIImageView = {
        let imgView = UIImageView()
        imgView.backgroundColor = .red
        return imgView
    }()
    
    let albumNameLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.text = "我喜欢的音乐"
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    
    let dowloadedNumLabel: UILabel = {
        let label = UILabel()
        label.text = "3首 已下载"
        label.font = UIFont.systemFont(ofSize: 10)
        label.textColor = .gray
        label.backgroundColor = .clear
        return label
    }()
    
    override func setupViews() {
        super.setupViews()
        
        backgroundColor = .white
        
        separatorLineView.isHidden = false
        separatorLineView.backgroundColor = UIColor(r: 230, g: 230, b: 230)
        
        addSubview(albumImgView)
        addSubview(albumNameLabel)
        addSubview(dowloadedNumLabel)
        
        albumImgView.anchor(self.topAnchor, left: self.leftAnchor, bottom: nil, right: nil, topConstant: 3, leftConstant: 3, bottomConstant: 0, rightConstant: 0, widthConstant: 50, heightConstant: 50)
        albumNameLabel.anchor(albumImgView.topAnchor, left: albumImgView.rightAnchor, bottom: nil, right: nil, topConstant: 5, leftConstant: 5, bottomConstant: 0, rightConstant: 0, widthConstant: 240, heightConstant: 20)
        dowloadedNumLabel.anchor(albumNameLabel.bottomAnchor, left: albumNameLabel.leftAnchor, bottom: nil, right: nil, topConstant: 5, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 240, heightConstant: 10)
    }
}

class ListHeader: DatasourceCell {
    let label: UILabel = {
        let label = UILabel()
        label.text = "我的歌单"
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.textColor = .black
        return label
    }()
    
    
    override func setupViews() {
        super.setupViews()
        
        backgroundColor = .white
        
        addSubview(label)
        
        label.anchor(topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 12, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
    }
}

class ListFooter: DatasourceCell {
    override func setupViews() {
        super.setupViews()
        
        backgroundColor = .white
    }
}
