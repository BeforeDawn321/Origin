//
//  WYYAPI.swift
//  WangyiMusicPlayer
//
//  Created by yuting jiang on 2018/2/10.
//  Copyright © 2018年 yuting jiang. All rights reserved.
//

import UIKit

struct WYYAPI {
    static let baseURL = "http://localhost:3000"
    
    static let phoneLogin = WYYAPI.baseURL + "/login/cellphone?phone="
    static let subaccount = WYYAPI.baseURL + "/user/subcount"
    
    static func login(accountNum: String, password: String) -> String {
        return WYYAPI.baseURL + accountNum + "&password=" + password
    }
    
    static func fetchUserInformation(uid: String) -> String {
        return WYYAPI.baseURL + "/user/detail" + uid
    }
    
    static func playlist(uid: String) -> String {
        return WYYAPI.baseURL + "/user/playlist" + uid
    }
    
    static func playlistDetail(id: String) -> String {
        return WYYAPI.baseURL + "/playlist/detail" + id
    }
    
    static func musicUrl(id: String) -> String {
        return WYYAPI.baseURL + "/music/url" + id
    }
    
    static func lyric(id: String) -> String {
        return WYYAPI.baseURL + "/lyric" + id
    }
    
}
