//
//  PlayerViewController.swift
//  WangyiMusicPlayer
//
//  Created by yuting jiang on 2018/2/22.
//  Copyright © 2018年 yuting jiang. All rights reserved.
//

import Foundation
import UIKit
import PandoraPlayer
import AVFoundation
import MediaPlayer

//let musics = ["Lorde - Green Light", "Ed Sheeran-Perfect", "Taylor Swift-Red", "Ed Sheeran-Photograph", "Owl City-Hot Air Balloon", "Ed Sheeran-Shape of You", "RADWIMPS (ラッドウィンプス)-なんでもないや (没什么大不了) (Movie ver.)", "Taylor Swift-Safe & Sound","Ed Sheeran-Thinking Out Loud"]

let sWidth = UIScreen.main.bounds.width
let sHeight = UIScreen.main.bounds.height
let imgw = 0.8 * sWidth
let imgh = sWidth
var musicList: [MusicList] = []

class PlayerViewController: UIViewController {
    var musicList: [MusicList] = []
    //open var audioPlayer: STKAudioPlayer!
    open var audioPlayer: AVAudioPlayer!
    static var queue = 0
    var timer: Timer!
    let slider = UISlider(frame: CGRect(x: 50, y: imgh + 80, width: sWidth - 100, height: 20))
    let playerButton = UIButton()
    let titleLabel = UILabel(frame: CGRect(x: 0, y: imgh + 125, width: sWidth, height: 45))
    let artistLabel = UILabel(frame: CGRect(x: 0, y: imgh + 170, width: sWidth, height: 30))
    let playTimeLablePlaying = UILabel(frame: CGRect(x: 0, y: imgh + 100, width: 60, height: 20))
    let playTimeLableRest = UILabel(frame: CGRect(x: sWidth - 60, y: imgh + 100, width: 60, height: 20))
    let imageView = UIImageView()
    var state: STKAudioPlayerState = []    //当前播放状态
    let disk: UIImageView = {
        let imgView = UIImageView()
        imgView.contentMode = .scaleAspectFill
        imgView.image = UIImage.init()
        imgView.image = #imageLiteral(resourceName: "Disk").setCircle()
        return imgView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        setNavBar()
        setPlayerView()
//        playingMusic()
        downloadFileFromURL(url:  PlayerDatasource.mediaUrl)
        //resetAudioPlayer()
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(tick), userInfo: nil, repeats: true)
    }
    
    func downloadFileFromURL(url: URL){
        
        var downloadTask:URLSessionDownloadTask
        downloadTask = URLSession.shared.downloadTask(with: url, completionHandler: { [weak self](URL, response, error) -> Void in
            self?.play(url: url)
        })
        
        downloadTask.resume()
    }
    
    func play(url: URL) {
        print("playing \(url)")
        
        do {
            self.audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer.prepareToPlay()
            audioPlayer.volume = 1.0
            audioPlayer.play()
        } catch let error as NSError {
            //self.player = nil
            print(error.localizedDescription)
        } catch {
            print("AVAudioPlayer init failed")
        }
        
    }
    
//    func resetAudioPlayer() {
//        var options = STKAudioPlayerOptions()
//        options.flushQueueOnSeek = true
//        options.enableVolumeMixer = true
//        audioPlayer = STKAudioPlayer(options: options)
//        
//        audioPlayer.isMeteringEnabled = true
//        audioPlayer.volume = 1
//        audioPlayer.delegate = self as! STKAudioPlayerDelegate as! AVAudioPlayerDelegate
//    }
    
    
    
    //缓冲完毕
    func audioPlayer(_ audioPlayer: STKAudioPlayer,
                     didFinishBufferingSourceWithQueueItemId queueItemId: NSObject) {
//        MPNowPlayingInfoCenter()
        resetLables()
    }
    
    //播放状态变化
    func audioPlayer(_ audioPlayer: STKAudioPlayer, stateChanged state: STKAudioPlayerState, previousState: STKAudioPlayerState) {
        self.state = state
        if state != .stopped && state != .error && state != .disposed {
        }
        resetLables()
    }
    
    //停止播放
    func stop() {
        audioPlayer.stop()
        Song.songArray = []
        PlayerViewController.queue = -1
    }
    
    //单独播放某个歌曲
//    func play(songUrl: URL) {
//        audioPlayer.play(songUrl)
//    }
    
//    //下一曲
//    func next() {
//        guard Song.songArray.count > 0 else {
//            return
//        }
//        PlayerViewController.queue = (currentIndex + 1) % queue.count
//        playWithQueue(queue: Song.songArray, index: PlayerViewController.queue)
//    }
//    
//    //上一曲
//    func prev() {
//        PlayerViewController.queue = max(0, PlayerViewController.queue - 1)
//        playWithQueue(queue: Song.songArray, index: PlayerViewController.queue)
//    }
    
    func getMusicItem() {
        Service.shareInstance.fetchMusicItems(musicId: Song.songArray[PlayerViewController.queue].id)
    }
    
    func playingMusic() {
        //print(musicList[PlayerViewController.queue])
//        let audioPath =  URL.init(fileURLWithPath: Bundle.main.path(forResource: musics[PlayerViewController.queue], ofType: "mp3")!)
        //let playerItem = AVPlayerItem(url: audioPath)
        print(PlayerDatasource.mediaUrl)
        let url = PlayerDatasource.mediaUrl
        //audioPlayer.play(url)
        print(PlayerDatasource.mediaUrl)
        
//        do {
//            print(PlayerDatasource.mediaUrl)
//            audioPlayer = try AVAudioPlayer(contentsOf:  PlayerDatasource.mediaUrl!)
//            audioPlayer.prepareToPlay()
//            audioPlayer.play()
//            print(audioPlayer)
//        } catch {
//            print(error)
//        }
    }
    
    
    func resetLables() {
//        titleLabel.text = musicList[queue].title
//        artistLabel.text = musicList[queue].author
        titleLabel.text = Song.songArray[PlayerViewController.queue].title
        artistLabel.text = Song.songArray[PlayerViewController.queue].artist.name
        
        playerButton.setImage(#imageLiteral(resourceName: "pause"), for: .normal)
        //imageView.image = UIImage(data: musicList[PlayerViewController.queue].imgData! as Data)
        //audioPlayer.resume()
    }
    
    func nextsong() {
        if PlayerViewController.queue == Song.songArray.count - 1 {
            PlayerViewController.queue = 0
            playingMusic()
            resetLables()
        }else {
            PlayerViewController.queue += 1
            playingMusic()
            resetLables()
        }
    }
    
    func fetchImg() -> UIImage {
        let url = URL(string: Song.songArray[PlayerViewController.queue].picUrl!)
        let data = try? Data(contentsOf: url!)
        let image: UIImage
//        if let imageData = data {
//            image = UIImage(data: imageData)!
//        }
        image = UIImage(data: data!)!
        return image
    }
    
    //    func fetchMusicList() {
    //
    //        for i in 0 ..< musics.count {
    //            let musicLists = MusicList()
    //            let audioPath =  URL.init(fileURLWithPath: Bundle.main.path(forResource: musics[i], ofType: "mp3")!)
    //            let playerItem = AVPlayerItem(url: audioPath)
    //            let metadataList = playerItem.asset.metadata
    //            for item in metadataList {
    //                guard let key = item.commonKey, let value = item.value else {
    //                    continue
    //                }
    //                switch key {
    //                case .commonKeyTitle:
    //                    musicLists.title = (value as? String)!
    //                case .commonKeyArtist:
    //                    musicLists.author = (value as? String)!
    //                case .commonKeyArtwork:
    //                    musicLists.imgData = (value as! NSData)
    //                //imageView.image = UIImage(data: (value as! NSData) as Data)
    //                default:
    //                    continue
    //                }
    //            }
    //            musicList.append(musicLists)
    //        }
    //
    //    }

}

class MusicList{
    var name: String?
    var author: String?
    var imgData: NSData?
    var title: String?
}
