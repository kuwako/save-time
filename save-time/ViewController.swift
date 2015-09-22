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
    let interval_sec : NSTimeInterval = 10
    var last_control_sec : Int = 0
    
    @IBOutlet weak var timeTable: NSTableView!
    
    // 記録ボタン
    @IBAction func saveButton(sender: AnyObject) {
        updateAppTableView()
    }
    
    // リセットボタン
    @IBAction func resetButton(sender: AnyObject) {
        // 配列内全削除
        appArr.removeAll()
        
        // テーブル更新
        timeTable.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Initialize appArr
        print("Initialize App")
        
        // 1分おきにその時起動中のアプリケーションを記録
        NSTimer.scheduledTimerWithTimeInterval(interval_sec, target: self, selector:"updateAppTableView", userInfo: nil, repeats: true)
        // コントロールに最後に触れてからの時間をカウントアップ
        NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector:"updateLastControlSec", userInfo: nil, repeats: true)
        
        // グローバルでキーダウンがあればカウントリセット
        NSEvent.addGlobalMonitorForEventsMatchingMask(NSEventMask.KeyDownMask, handler: {(evt: NSEvent!) -> Void in
            self.last_control_sec = 0
        });
        
        // マウスが動いたらカウントリセット
        NSEvent.addGlobalMonitorForEventsMatchingMask(NSEventMask.MouseMovedMask, handler: {(evt: NSEvent!) -> Void in
            self.last_control_sec = 0
        });
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
        let isActive = appArr[row].isActive
        let columnName = tableColumn?.identifier
        
        if columnName == "time" {
            return timeStr
        }
        else if columnName == "application" {
            return appName
        }
        else if columnName == "active" {
            return isActive
        }
        
        return ""
    }
    
    // テーブルを更新するメソッド
    func updateAppTableView() {
        // 起動中のアプリケーション一覧   を取得
        let runningApps = NSWorkspace.sharedWorkspace().runningApplications
        
        for app in runningApps {
            
            // アクティブなものを出力
            if app.active {
                let appObj = ApplicationData()
                appObj.appName = app.localizedName!
                
                // インターバルの間に最後にコントロールをさわったかを判定
                if last_control_sec > Int(interval_sec) {
                    appObj.isActive = "×"
                } else {
                    appObj.isActive = "○"
                }
             
                // 配列の先頭に追加
                appArr.insert(appObj, atIndex: 0)
            }
        }
        
        // テーブル更新
        timeTable.reloadData()
    }
    
    func updateLastControlSec() -> Void {
        last_control_sec++
    }
    

}

