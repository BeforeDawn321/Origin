//
//  SongTableDatasource.swift
//  WangyiMusicPlayer
//
//  Created by yuting jiang on 2018/2/27.
//  Copyright © 2018年 yuting jiang. All rights reserved.
//

import Foundation
import LBTAComponents
import TRON
import SwiftyJSON

class SongTableDataSource: Datasource, JSONDecodable {
    var songs: [Song] = []
    
    required init(json: JSON) throws {
        let albumDetails = json["result"]["tracks"].array
        
        for song in albumDetails! {
            let name = song["name"].stringValue
            let songId = song["id"].stringValue
            let artistsArray = song["artists"].array
            let imgUrl = song["album"]["picUrl"].stringValue
            var artists: [Artist] = []
            
            for artist in artistsArray! {
                let artistName = artist["name"].stringValue
                let artistId = artist["id"].stringValue
                let artist = Artist(name: artistName, id: artistId)
                artists.append(artist)
            }
            let music = Song(title: name, id: songId, artist: artists[0], picUrl: imgUrl)
            songs.append(music)
        }
        Song.songArray = songs
        print(songs)
    }
    
    override func headerClasses() -> [DatasourceCell.Type]? {
        return[SongTableHeader.self]
    }

    override func cellClasses() -> [DatasourceCell.Type] {
        return[SongCell.self]
    }
    
    override func numberOfSections() -> Int {
        return 1
    }
    
    override func numberOfItems(_ section: Int) -> Int {
        return Song.songArray.count
    }
    
    override func item(_ indexPath: IndexPath) -> Any? {
        return Song.songArray[indexPath.item]
    }
}
