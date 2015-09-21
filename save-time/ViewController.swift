//
//  ViewController.swift
//  save-time
//
//  Created by masaki_kuwako on 2015/09/19.
//  Copyright © 2015年 masaki_kuwako. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    var appArr : [ApplicationData] = []
    
    @IBOutlet weak var timeTable: NSTableView!
    @IBAction func saveButton(sender: AnyObject) {
        updateAppTableView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Initialize appArr
        print("Initialize App")
        
        // 1分おきにその時起動中のアプリケーションを記録
        NSTimer.scheduledTimerWithTimeInterval(10, target: self, selector:"updateAppTableView", userInfo: nil, repeats: true)
    }

    override var representedObject: AnyObject? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    // NSTableView使うのに必要
    func numberOfRowsInTableView(timeTable: NSTableView) -> Int
    {
        return appArr.count
    }
    
    // NSTableView使うのに必要
    func tableView(timeTable: NSTableView, objectValueForTableColumn tableColumn: NSTableColumn?, row: Int) -> AnyObject? {
        let timeStr = appArr[row].getTimeStr()
        let appName = appArr[row].appName
        let columnName = tableColumn?.identifier
        
        if columnName == "time" {
            return timeStr
        }
        else if columnName == "application" {
            return appName
        }
        else if columnName == "active" {
            return "true"
        }
        
        return ""
    }
    
    // テーブルを更新するメソッド
    func updateAppTableView() {
        // 起動中のアプリケーション一覧を取得
        let runningApps = NSWorkspace.sharedWorkspace().runningApplications
        
        for app in runningApps {
            
            // アクティブなものを出力
            if app.active {
                let appObj = ApplicationData()
                appObj.appName = app.localizedName!
             
                // 配列の先頭に追加
                appArr.insert(appObj, atIndex: 0)
            }
        }
        
        // テーブル更新
        timeTable.reloadData()
    }
}

