//
//  SongCell.swift
//  WangyiMusicPlayer
//
//  Created by yuting jiang on 2018/3/2.
//  Copyright © 2018年 yuting jiang. All rights reserved.
//

import LBTAComponents

class SongCell: DatasourceCell {
    override var datasourceItem: Any? {
        didSet {
            guard let songs = datasourceItem as? Song else { return }
            let name = songs.title
            let artist = songs.artist
            //print(songs.artist)
            songNameLabel.text = name
            artistLabel.text = artist.name
        }
    }
    
    let songNameLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 20)
        label.backgroundColor = .white
        return label
    }()
    
    let artistLabel: UILabel = {
        let label = UILabel()
        label.text = "artist" + "-" + "fromAlbum"
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 13)
        label.backgroundColor = .white
        return label
    }()
    
    override func setupViews() {
        addSubview(songNameLabel)
        addSubview(artistLabel)
        
        songNameLabel.anchor(topAnchor, left: leftAnchor, bottom: nil, right: nil, topConstant: 5, leftConstant: 10, bottomConstant: 0, rightConstant: 0, widthConstant: UIScreen.main.bounds.width, heightConstant: 30)
        artistLabel.anchor(songNameLabel.bottomAnchor, left: songNameLabel.leftAnchor, bottom: nil, right: rightAnchor, topConstant: 3, leftConstant: 0, bottomConstant: 5, rightConstant: 0, widthConstant: 0, heightConstant: 15)
    }
}
