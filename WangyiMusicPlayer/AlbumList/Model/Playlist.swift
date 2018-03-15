//
//  Playlist.swift
//  WangyiMusicPlayer
//
//  Created by yuting jiang on 2018/2/24.
//  Copyright © 2018年 yuting jiang. All rights reserved.
//

import Foundation

struct Playlist {
    static var playlists: [Playlist] = []

    let name: String
    let id: String
    let trackCount: Int
    let coverImgUrl: String
}
