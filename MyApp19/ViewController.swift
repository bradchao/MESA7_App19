//
//  ViewController.swift
//  MyApp19
//
//  Created by iii on 2017/7/3.
//  Copyright © 2017年 iii. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let gamedataFile = NSHomeDirectory() + "/Documents/gamedata.plist"
    let appMain = UIApplication.shared.delegate as! AppDelegate
    
    
    
    @IBOutlet weak var inputName: UITextField!
    
    
    @IBAction func saveName(_ sender: Any) {
        
        if let gdata = NSMutableDictionary(contentsOfFile: gamedataFile) {
            gdata["name"] = inputName.text
            gdata["test"] = "Hello, Test"
            gdata.write(toFile: gamedataFile, atomically: true)
        }
        
        
    }
    
    @IBAction func queryDB(_ sender: Any) {
        
        let sql = "SELECT * FROM cust"
        var point:OpaquePointer? = nil
        if sqlite3_prepare(appMain.db, sql, -1, &point, nil) == SQLITE_OK {
            print("OK")
        }
        
        while sqlite3_step(point) == SQLITE_ROW {
            let cname = sqlite3_column_text(point, 1)
            
            print(String(cString: cname!))
        }
        
        
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let gdata = NSMutableDictionary(contentsOfFile: gamedataFile) {
            
            if let name = gdata["name"] {
                print(name)
            }
            if let test = gdata["test"] {
                print(test)
            }
            
        }
        
        
        
    }

}

