//
//  Service.swift
//  WangyiMusicPlayer
//
//  Created by yuting jiang on 2018/2/19.
//  Copyright © 2018年 yuting jiang. All rights reserved.
//

import SwiftyJSON
import TRON
import LBTAComponents

struct Service {
    static let shareInstance = Service()

    //let login = WYYAPI.phoneLogin + LoginViewController.accountNumString + "&password=" + LoginViewController.password
    
    let tron = TRON(baseURL: "http://localhost:3000")
    
    func fetchMusicLyric(musicId: String) {
        let request: APIRequest<LyricContent, JSONError> = tron.swiftyJSON.request("lyric")
        request.parameters = ["id": musicId]
        
        request.perform(withSuccess: { (songs) in
            print(songs)
            print("succesfully fetch song details!")
        }) { (err) in
            print("failed to fetch song detail\n", err)
        }
    }
    
    func fetchMusicItems(musicId: String) {
        let request: APIRequest<Songs, JSONError> = tron.swiftyJSON.request("/music/url")
        request.parameters = ["id": musicId]
        
        request.perform(withSuccess: { (songs) in
            //print(songs)
            print("succesfully fetch song details!")
            switch PlayerViewController.situation {
            case 1:
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "nextSong"), object: nil)
            case -1:
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "nextSong"), object: nil)
            case 0 :
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "playSonginit"), object: nil)
            default:
                break
            }
        }) { (err) in
            print("failed to fetch song detail\n", err)
        }
    }

    func fetchListDetails(albumId: String, completion: @escaping(SongTableDataSource) -> ()) {
        let request: APIRequest<SongTableDataSource, JSONError> = tron.swiftyJSON.request("/playlist/detail")
        request.parameters = ["id": albumId]
        
        request.perform(withSuccess: { (songTableDatasource) in
            print("succesfully fetch list details!")
            completion(songTableDatasource)
        }) { (err) in
            print("failed to fetch list detail\n", err)
        }
    }
    
    func fetchListsNeed(uid: String ,completion: @escaping (ListDatasource) -> ()) {
        let request: APIRequest<ListDatasource, JSONError> = tron.swiftyJSON.request("/user/playlist")
        request.parameters = ["uid": uid]

        request.perform(withSuccess: { (listDatasource) in
            print("Successfully fetch lists json")
            completion(listDatasource)
        }) { (err) in
            print("failed to fetch json\n", err)
        }
    }
    
    func fetchUid(phone: String, password: String) {
        let request: APIRequest<Accounts, JSONError> = tron.swiftyJSON.request("/login/cellphone")
        request.parameters = ["phone": phone, "password": password]
        
        request.perform(withSuccess: { (accounts) in
            print("Successfully fetch lists json")
            //print(accounts)
        }) { (err) in
            print("failed to fetch json\n", err)
        }
    }
}

class LyricContent: JSONDecodable {
    required init(json: JSON) throws {
        let lyric = json["lrc"]["lyric"].stringValue
        Lyric.lyrConent = lyric
        print(lyric)
        print(Lyric.getLrcMS(lrcName: lyric)[3].content, Lyric.getLrcMS(lrcName: lyric)[3].beginTime)
    }
}

class Home: JSONDecodable {
    required init(json: JSON) throws {
        print("Now ready to parse JSON/n", json)
    }
}

class JSONError: JSONDecodable {
    required init(json: JSON) throws {
        print("JSON ERROR!!")
    }
}
