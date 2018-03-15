//
//  PlayerViewController02.swift
//  WangyiMusicPlayer
//
//  Created by yuting jiang on 2018/3/8.
//  Copyright © 2018年 yuting jiang. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation
import MediaPlayer

let playerButton = UIButton()
let titleLabel = UILabel(frame: CGRect(x: 0, y: imgh + 125, width: sWidth, height: 45))
let artistLabel = UILabel(frame: CGRect(x: 0, y: imgh + 170, width: sWidth, height: 30))
let playTimeLablePlaying = UILabel(frame: CGRect(x: 0, y: imgh + 100, width: 60, height: 20))
let playTimeLableRest = UILabel(frame: CGRect(x: sWidth - 60, y: imgh + 100, width: 60, height: 20))

var lrcScrollView: UIScrollView!
var lrcVC: LyricViewController = {
    return LyricViewController()
}()
let imageView = UIImageView()
let disk: UIImageView = {
    let imgView = UIImageView()
    imgView.contentMode = .scaleAspectFill
    imgView.image = UIImage.init()
    imgView.image = #imageLiteral(resourceName: "disc")
    return imgView
}()

let needleImgView: UIImageView = {
    let imgView = UIImageView()
    imgView.image = #imageLiteral(resourceName: "needle")
    return imgView
}()

let bgImgView: UIImageView = {
    let imgView = UIImageView()
    imgView.backgroundColor = .black
    imgView.contentMode = .scaleAspectFill
    return imgView
}()

let slider = UISlider(frame: CGRect(x: 50, y: imgh + 80, width: sWidth - 100, height: 20))

class PlayerViewController: UIViewController {
    open var audioPlayer = AVPlayer()
    open var playItem: AVPlayerItem?
    static var queue: Int = PlayerViewController.queue
    static var nextQueue: Int = PlayerViewController.nextQueue
    static var situation = 0
    
    var timer: Timer!
    
    var isPlaying = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.audioPlayer.currentItem?.cancelPendingSeeks()
        self.audioPlayer.currentItem?.asset.cancelLoading()
        //当代码中调用了addPeriodicTimeObserverForInterval方法的时候，还需要释放addPeriodicTimeObserverForInterval返回的playbackObserver对象
        //self.audioPlayer.removeTimeObserver:playbackObserver()
        self.playItem = AVPlayerItem(url: PlayerDatasource.mediaUrl)
        self.audioPlayer = AVPlayer(playerItem: self.playItem)
        
        setNavBar()
        setPlayerView()
        playingMusic()
        
        //2.获得应用程序的主线程
        let isMain =  Thread.isMainThread
        print(isMain, "1")
        
        self.timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(tick), userInfo: nil, repeats: true)

        
        NotificationCenter.default.addObserver(self, selector: #selector(resetPlayer), name: NSNotification.Name(rawValue: "nextSong"), object: nil)
    }

    func playingMusic() {
        isPlaying = true
        imageView.rotate360Degree()
        disk.rotate360Degree()
        audioPlayer.play()
    }

    @objc func resetPlayer() {
        //getMusicItem()
        audioPlayer.pause()
        resetLables()

        self.playItem = AVPlayerItem(url: PlayerDatasource.mediaUrl)
        self.audioPlayer = AVPlayer(playerItem: self.playItem)
        audioPlayer.play()
        isPlaying = true
    }
    
    func stopMusic() {
        audioPlayer.pause()
        isPlaying = false
        imageView.stopRotate()
        disk.stopRotate()
    }
    
    func resetLables() {
//        titleLabel.text = Song.songArray[PlayerViewController.queue].title
//        artistLabel.text = Song.songArray[PlayerViewController.queue].artist.name
        navigationItem.title = Song.songArray[PlayerViewController.queue].title
        bgImgView.image = fetchImg()
        imageView.image = fetchImg().setCircle()
        
        playerButton.setImage(#imageLiteral(resourceName: "pause"), for: .normal)
    }
    
    func nextsong() {
        PlayerViewController.situation = 1
        
        if PlayerViewController.queue == Song.songArray.count - 1 {
            PlayerViewController.queue = 0
            getMusicItem()
        } else {
            PlayerViewController.queue += 1
            getMusicItem()
        }
    }
    
    func lastSong() {
        PlayerViewController.situation = -1
        
        if PlayerViewController.queue == 0{
            PlayerViewController.queue = Song.songArray.count - 1
            getMusicItem()
        } else {
            PlayerViewController.queue -= 1
            getMusicItem()
        }
    }
    
    func getMusicItem() {
        Service.shareInstance.fetchMusicItems(musicId: Song.songArray[PlayerViewController.queue].id)
        resetLables()
    }
    
    func fetchImg() -> UIImage {
        let url = URL(string: Song.songArray[PlayerViewController.queue].picUrl!)
        let data = try? Data(contentsOf: url!)
        let image: UIImage
        image = UIImage(data: data!)!
        return image
    }
    


}
























