//
//  File.swift
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


let sWidth = UIScreen.main.bounds.width
let sHeight = UIScreen.main.bounds.height
let imgw = 0.8 * UIScreen.main.bounds.width
let imgh = UIScreen.main.bounds.width

extension PlayerViewController {
    
    
    func setPlayerView() {
        //设置界面

        bgImgView.image = fetchImg()
        self.view.addSubview(bgImgView)
        bgImgView.snp.makeConstraints { (make) in
            make.width.equalTo(sWidth)
            make.height.equalTo(sHeight)
            make.center.equalTo(self.view.center)
        }
        
        let blueEffect = UIBlurEffect(style: .dark)
        let blueEffectView = UIVisualEffectView(effect: blueEffect)
        self.view.addSubview(blueEffectView)
        blueEffectView.snp.makeConstraints { (make) in
            make.width.equalTo(sWidth)
            make.height.equalTo(sHeight)
            make.center.equalTo(self.view.center)
        }
        
        let listButton = UIButton(frame: CGRect(x: 0.1 * sWidth, y: 0.85 * sHeight + 20, width: 0.1 * sWidth, height: 0.1 * sWidth))
        listButton.setImage(UIImage.init(named: "view-list.png"), for: .normal)
        listButton.addTarget(self, action: #selector(listButtonTapped(sender:)), for: .touchUpInside)
        self.view.addSubview(listButton)
        
        let heartButton = UIButton(frame: CGRect(x: 0.8 * sWidth, y: 0.85 * sHeight + 20, width: 0.1 * sWidth, height: 0.1 * sWidth))
        heartButton.setImage(UIImage.init(named: "heart.png"), for: .normal)
        heartButton.addTarget(self, action: #selector(lastSongButtonTapped(sender:)), for: .touchUpInside)
        self.view.addSubview(heartButton)
        
        self.view.addSubview(disk)
        disk.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view)
            make.centerY.equalTo(self.view).offset(-60)
            make.width.equalTo(310)
            make.height.equalTo(310)
        }
       
        needleImgView.layer.anchorPoint = CGPoint(x: 0.25, y: 0.16)
        self.view.addSubview(needleImgView)
        needleImgView.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view).offset(-5)
            make.centerY.equalTo(self.view).offset(-300)
            make.width.equalTo(100)
            make.height.equalTo(170)
        }
        
        imageView.image = UIImage.init()
        imageView.image = fetchImg().setCircle()
        self.view.addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view)
            make.centerY.equalTo(self.view).offset(-60)
            make.width.equalTo(200)
            make.height.equalTo(200)
        }
        
        slider.minimumValue = 0
        slider.maximumValue = Float(CMTimeGetSeconds(playItem!.asset.duration))
        print(Float(CMTimeGetSeconds(playItem!.asset.duration)))
        slider.value = 0
        slider.isContinuous = true
        slider.addTarget(self, action: #selector(sliderChanged(sender: )), for: .valueChanged)
        self.view.addSubview(slider)

        playTimeLablePlaying.textAlignment = .center
        playTimeLablePlaying.textColor = .lightGray
        playTimeLablePlaying.font = UIFont(name: "Default", size: 1)
        playTimeLablePlaying.text = "00:00"
        self.view.addSubview(playTimeLablePlaying)
        
        playTimeLableRest.textAlignment = .center
        playTimeLableRest.textColor = .lightGray
        playTimeLableRest.font = UIFont(name: "Default", size: 1)
        playTimeLableRest.text = "00:00"
        self.view.addSubview(playTimeLableRest)
        
        setupButtomButtons()
    }
    
    func setupButtomButtons() {
        let buttonView = UIView()
        buttonView.backgroundColor = .clear
        
        let backButtonView = UIView()
        backButtonView.backgroundColor = .clear
        
        let playButtonView = UIView()
        playButtonView.backgroundColor = .clear
        
        let nextButtonView = UIView()
        nextButtonView.backgroundColor = .clear
        
        let listButtonView = UIView()
        listButtonView.backgroundColor = .clear
        
        let stackView = UIStackView(arrangedSubviews: [buttonView, backButtonView, playButtonView, nextButtonView, listButtonView])
        stackView.distribution = .fillEqually
        stackView.axis = .horizontal
        self.view.addSubview(stackView)
        stackView.anchor(nil, left: self.view.leftAnchor, bottom: self.view.bottomAnchor, right: self.view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 30, rightConstant: 0, widthConstant: sWidth, heightConstant: 50)
        
        playerButton.setImage(#imageLiteral(resourceName: "pause"), for: .normal)
        playerButton.addTarget(self, action: #selector(playerButtonTapped(sender:)), for: .touchUpInside)
        self.view.addSubview(playerButton)
        playerButton.snp.makeConstraints { (make) in
            make.width.equalTo(45)
            make.height.equalTo(45)
            make.centerX.equalTo(playButtonView)
            make.centerY.equalTo(playButtonView)
        }
        
        let nextSongButton = UIButton()
        nextSongButton.setImage(#imageLiteral(resourceName: "next"), for: .normal)
        nextSongButton.addTarget(self, action: #selector(nextSongButtonTapped(sender:)), for: .touchUpInside)
        self.view.addSubview(nextSongButton)
        nextSongButton.snp.makeConstraints { (make) in
            make.width.equalTo(34)
            make.height.equalTo(34)
            make.centerX.equalTo(nextButtonView)
            make.centerY.equalTo(nextButtonView)
        }
        
        let lastSongButton = UIButton()
        lastSongButton.setImage(#imageLiteral(resourceName: "back"), for: .normal)
        lastSongButton.addTarget(self, action: #selector(lastSongButtonTapped(sender:)), for: .touchUpInside)
        self.view.addSubview(lastSongButton)
        lastSongButton.snp.makeConstraints { (make) in
            make.width.equalTo(34)
            make.height.equalTo(34)
            make.centerX.equalTo(backButtonView)
            make.centerY.equalTo(backButtonView)
        }
    }
}
