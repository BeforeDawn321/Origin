//
//  SongTableViewControlle.swift
//  WangyiMusicPlayer
//
//  Created by yuting jiang on 2018/2/23.
//  Copyright © 2018年 yuting jiang. All rights reserved.
//

import LBTAComponents

class SongTableViewController: DatasourceController {
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        collectionViewLayout.invalidateLayout()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavBar()
        
        NotificationCenter.default.addObserver(self, selector: #selector(loadPlayerView), name: NSNotification.Name(rawValue: "playSonginit"), object: nil)

        Service.shareInstance.fetchListDetails(albumId: AlbumDetail.albumId) { (songTableDatasource) in
            self.datasource = songTableDatasource
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 230)
    }
    
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    override func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        PlayerViewController.queue = indexPath.item
        Service.shareInstance.fetchMusicItems(musicId: Song.songArray[PlayerViewController.queue].id)
        Service.shareInstance.fetchMusicLyric(musicId: Song.songArray[PlayerViewController.queue].id)
    }
    
    @objc func loadPlayerView() {
        let playerViewController = PlayerViewController()
        self.navigationController?.pushViewController(playerViewController, animated: true)
    }
}

extension SongTableViewController {
    func setNavBar() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true

        navigationItem.title = "歌单"
        navigationItem.backBarButtonItem?.title = ""
    }
}
