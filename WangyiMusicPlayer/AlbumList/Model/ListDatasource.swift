//
//  File.swift
//  WangyiMusicPlayer
//
//  Created by yuting jiang on 2018/2/19.
//  Copyright © 2018年 yuting jiang. All rights reserved.
//

import LBTAComponents
import TRON
import SwiftyJSON

class ListDatasource: Datasource, JSONDecodable {
    let word = ["Hello", "How", "Are"]

    required init(json: JSON) throws {
        let arrayPlaylist = json["playlist"].array
        var playlists = [Playlist]()
        
        
        for playlist in arrayPlaylist!  {
            let name = playlist["name"].stringValue
            let id = playlist["id"].stringValue
            let trackCount = playlist["trackCount"].intValue
            let coverImgUrl = playlist["coverImgUrl"].stringValue
            
            let list = Playlist(name: name, id: id, trackCount: trackCount, coverImgUrl: coverImgUrl)
            
            playlists.append(list)
        }
        Playlist.playlists = playlists
    }
    
    
    override func headerClasses() -> [DatasourceCell.Type]? {
        return [ListHeader.self]
    }
    
    override func footerClasses() -> [DatasourceCell.Type]? {
        return[ListFooter.self]
    }
    
    override func cellClasses() -> [DatasourceCell.Type] {
        return [ListCell.self]
    }
    
    override func item(_ indexPath: IndexPath) -> Any? {
        return Playlist.playlists[indexPath.item]
    }
    
    override func numberOfItems(_ section: Int) -> Int {
        return Playlist.playlists.count
    }
    
    override func numberOfSections() -> Int {
        return 1
    }
    
}
