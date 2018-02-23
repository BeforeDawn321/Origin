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
//        let listViewDatasource = ListDatasource()
//        self.datasource = listViewDatasource
        fetchHomeNeed()
    }
    
    let tron = TRON(baseURL: WYYAPI.baseURL)
    let str = "/login/cellphone?phone=15522010953&password=lovingBP"
    
    
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
    
    fileprivate func fetchHomeNeed() {
        let request: APIRequest<Home, JSONError> = tron.swiftyJSON.request("/login/cellphone?phone=15522010953&password=lovingBP")
        print(str.urlDecoded())
        print(NSURL(string: str))
        
        request.perform(withSuccess: { (home) in
            print("Successfully fetch json")
        }) { (err) in
            
            print("failed to fetch json\n", err)
        }
        
        print(124)
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
    
    
}
