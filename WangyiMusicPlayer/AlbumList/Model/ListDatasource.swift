//
//  File.swift
//  WangyiMusicPlayer
//
//  Created by yuting jiang on 2018/2/19.
//  Copyright © 2018年 yuting jiang. All rights reserved.
//

import LBTAComponents

class ListDatasource: Datasource {
    let word = ["Hello", "How", "Are"]
    
    override func headerClasses() -> [DatasourceCell.Type]? {
        return [ListHeader.self]
    }
    
    override func footerClasses() -> [DatasourceCell.Type]? {
        return[ListFooter.self]
    }
    
    override func cellClasses() -> [DatasourceCell.Type] {
        return [ListCell.self]
    }
    
    override func item(_ indexPath: IndexPath) -> Any? {
        return word[indexPath.item]
    }
    
    override func numberOfItems(_ section: Int) -> Int {
        return word.count
    }
    
    override func numberOfSections() -> Int {
        return 1
    }
    
}
