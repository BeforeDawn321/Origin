//
//  Album.swift
//  WangyiMusicPlayer
//
//  Created by yuting jiang on 2018/2/27.
//  Copyright © 2018年 yuting jiang. All rights reserved.
//

import Foundation
import SwiftyJSON
import TRON

struct AlbumDetail {
    static var albumId: String = ""
    static var albumName: String = ""
    static var albumCoverImgUrl: String = ""
}

struct Song {
    let title: String
    let id: String
    let artist: Artist
    let picUrl: String?
    static var songArray: [Song] = []
   
}

class Songs: JSONDecodable {
    
    required init(json: JSON) throws {
        let songDetailArray = json["data"].array
        var musicUrl: String = ""
        
        for songDetail in songDetailArray! {
            musicUrl = songDetail["url"].stringValue
            print(musicUrl)
        }
        PlayerDatasource.mediaUrl = URL(string: musicUrl)!
        //NotificationCenter.default.post(name: NSNotification.Name(rawValue: "playSonginit"), object: nil)
    }
}
