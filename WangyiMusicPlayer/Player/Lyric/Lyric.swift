//
//  Lyric.swift
//  WangyiMusicPlayer
//
//  Created by yuting jiang on 2018/3/8.
//  Copyright © 2018年 yuting jiang. All rights reserved.
//

import Foundation
import SwiftyJSON
import TRON

class Lyric {
    var beginTime : TimeInterval = 0
    var endTime : TimeInterval = 0
    
    var content : String = ""
    
    static var lyrConent: String = ""

    class func getLrcMS(lrcName : String?) -> ([Lyric]) {
        let conentArray = Lyric.lyrConent.components(separatedBy: "\n")
        var resultArray = [Lyric]()
        
        for  var conentString in conentArray {
            if conentString.contains("[ti:") || conentString.contains("[ar:") || conentString.contains("[t_time:"){
                continue
            }
            //删除第一个括号
            conentString = conentString.replacingOccurrences(of: "[", with: "")
            let detailArray = conentString.components(separatedBy: "]")
            if detailArray.count != 2 {
                continue
            }
            let startTime = QQTimeTool.getFormatTimeToTimeInval(format: detailArray[0])
            var content = detailArray[1]
            
            //content.removeSubrange(<#T##bounds: Range<String.Index>##Range<String.Index>#>)
            content = content.replacingOccurrences(of: "\r", with: "")
            let model = Lyric()
            resultArray.append(model)
            model.beginTime = startTime
            model.content = content
        }
        
        //遍历resultArray 第二个参数的开始时间是第一个的结束时间
        let count = resultArray.count
        for rs in 0..<count {
            if rs == count - 1 {
                break
            }
            let lrcM = resultArray[rs]
            let nextLrcM = resultArray[rs + 1]
            lrcM.endTime = nextLrcM.beginTime
        }
        return resultArray
    }
    
    class func getCurrntLrcModel (currentTime : TimeInterval, lrcModel : [Lyric]) -> (row : Int , model : Lyric?) {
        
        var index = 0
        for lrcM in lrcModel {
            
            if lrcM.endTime >= currentTime && lrcM.beginTime <= currentTime {
                return (index, lrcM)
            }
            index += 1
        }
        return (0,nil)
    }
}
