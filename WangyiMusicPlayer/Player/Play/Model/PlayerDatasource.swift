//
//  PlayerDatasource.swift
//  WangyiMusicPlayer
//
//  Created by yuting jiang on 2018/3/4.
//  Copyright © 2018年 yuting jiang. All rights reserved.
//

import AVFoundation
import PandoraPlayer
import TRON
import SwiftyJSON
import MediaPlayer

class PlayerDatasource {
    static var mediaUrl: URL = PlayerDatasource.mediaUrl
    
}

class Player {
    var audioPlayer: AVAudioPlayer?

    func setPlayer() {
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: PlayerDatasource.mediaUrl)
        
        } catch {
            audioPlayer = nil
        }
    }
}
