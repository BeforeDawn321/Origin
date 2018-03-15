//
//  buttonObjc.swift
//  WangyiMusicPlayer
//
//  Created by yuting jiang on 2018/3/6.
//  Copyright © 2018年 yuting jiang. All rights reserved.
//

import Foundation
import UIKit
import PandoraPlayer
import AVFoundation
import MediaPlayer

extension PlayerViewController {
    @objc func playerButtonTapped(sender: UIButton) {
        if isPlaying == true {
            stopMusic()
            needleImgView.rotateminus90Degree()
            sender.setImage(#imageLiteral(resourceName: "play"), for: .normal)
        } else {
            playingMusic()
            needleImgView.rotate90Degree()
            sender.setImage(#imageLiteral(resourceName: "pause"), for: .normal)
        }
        print(isPlaying)
    }
    
    @objc func commentButtonTapped(sender: UIButton) {
        let commentViewController = CommentViewController()
        self.navigationController?.pushViewController(commentViewController, animated: true)
    }
    
    @objc func nextSongButtonTapped(sender: UIButton) {
        nextsong()
    }
    
    @objc func lastSongButtonTapped(sender: UIButton) {
        lastSong()
    }
    
    @objc func sliderChanged(sender: UISlider){
        let targetTime = CMTimeMake(Int64(sender.value), 1)
        audioPlayer.seek(to: targetTime)
//        audioPlayer.currentTime = TimeInterval(sender.value)
//        audioPlayer.progress.isEqual(to: TimeInterval(sender.value))
    }
    
    @objc func listButtonTapped(sender: UIButton) {
        //let musicList =  MusicListTableViewController()
        //self.navigationController?.pushViewController(musicList, animated: true)
    }
    
    @objc func tick() {
        if isPlaying == true {
            //更新进度条进度值
            let duration = playItem!.asset.duration
            let seconds = CMTimeGetSeconds(duration)
            let currentTime = CMTimeGetSeconds(self.audioPlayer.currentTime())
            slider.value = Float(currentTime)
//            print(Float(currentTime))
//            print("slidervalue", slider.value)
            
            //一个小算法，来实现00：00这种格式的播放时间
            let all: Int = Int(currentTime)
            var m: Int = all % 60
            var f: Int = Int(all / 60)
            var time: String = ""
            if f < 10 {
                time = "0\(f):"
            } else { time = "\(f)" }
            if m < 10 {
                time += "0\(m)"
            } else { time += "\(m)" }
            playTimeLablePlaying.text = time
            
            let rest: Int = Int(seconds - currentTime)
            time = ""
            m = rest % 60
            f = Int(rest / 60)
            if f < 10 {
                time = "0\(f):"
            } else {
                time = "\(f)"
            }
            if m < 10 {
                time += "0\(m)"
            } else {
                time += "\(m)"
            }
            playTimeLableRest.text = time
            if seconds - currentTime < 0.5 {
                nextsong()
            }
        }
    }
}
