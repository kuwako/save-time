//
//  ApplicationData.swift
//  save-time
//
//  Created by masaki_kuwako on 2015/09/20.
//  Copyright © 2015年 masaki_kuwako. All rights reserved.
//

import Foundation

class ApplicationData: NSObject{
    var time: NSDate = NSDate()
    var appName: String = "application name"
    var isActive :Bool = true

    func getTimeStr() -> String {
        let jaLocale = NSLocale(localeIdentifier: "ja_JP")
        let fmt = NSDateFormatter()
        fmt.locale = jaLocale
        fmt.timeStyle = .ShortStyle
        fmt.dateStyle = .ShortStyle
        
        return fmt.stringFromDate(self.time)
    }
}
