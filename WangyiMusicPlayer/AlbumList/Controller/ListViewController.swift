//
//  ListViewController.swift
//  WangyiMusicPlayer
//
//  Created by yuting jiang on 2018/2/19.
//  Copyright © 2018年 yuting jiang. All rights reserved.
//

import LBTAComponents
import UIKit
import TRON
import SwiftyJSON

class ListViewController: DatasourceController {
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        collectionViewLayout.invalidateLayout()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBarItems()
//        ModalTransitionMediator.instance.setListener(listener: self)
        NotificationCenter.default.addObserver(self, selector: #selector(loadList), name: NSNotification.Name(rawValue: "load"), object: nil)

        if Accounts.loginType == 1 {
            Service.shareInstance.fetchListsNeed(uid: Accounts.userId) { (listDatasource) in
                self.datasource = listDatasource
                print(1)
            }
        }
    }
   
    @objc func loadList(){
        //load data here
        if Accounts.loginType == 1 {
            Service.shareInstance.fetchListsNeed(uid: Accounts.userId) { (listDatasource) in
                self.datasource = listDatasource
                //print(listDatasource, Accounts.userId)
                print(2)
                self.collectionView!.reloadData()
            }
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 56)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 80)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        AlbumDetail.albumId = Playlist.playlists[indexPath.item].id
        AlbumDetail.albumName = Playlist.playlists[indexPath.item].name
        AlbumDetail.albumCoverImgUrl = Playlist.playlists[indexPath.item].coverImgUrl
        
        let songTableViewController = SongTableViewController()
        self.navigationController?.pushViewController(songTableViewController, animated: true)
    }
    
    
}
