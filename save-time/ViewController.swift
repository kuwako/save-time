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
        
        let app = NSApplication.sharedApplication()
        print(app.mainWindow!.title)
        
        let appObj = ApplicationData()
        appObj.appName = app.mainWindow!.title
        
        appArr.append(appObj)

        timeTable.reloadData()
        
//        for obj in winArr {
//            NSLog("window = %@",obj.title)
//        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Initialize appArr
        print("Initialize App")
        print(appArr.count)
        if self.appArr.count == 0 {
            var appData : ApplicationData!
            
            appData = ApplicationData()
            appData.appName="masaki"
            appArr.append(appData)
        }
    }

    override var representedObject: AnyObject? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    func numberOfRowsInTableView(timeTable: NSTableView) -> Int
    {
        return appArr.count
    }
    
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
}

