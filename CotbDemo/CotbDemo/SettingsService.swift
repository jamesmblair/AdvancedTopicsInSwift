//
//  SettingsService.swift
//  CotbDemo
//
//  Created by James Blair on 8/10/16.
//  Copyright © 2016 James Blair. All rights reserved.
//

import Foundation

struct MySettings {
    let greeting: String
    let name: String
    
    func with(greeting greeting: String) -> MySettings {
        return MySettings(greeting: greeting, name: name)
    }
    
    func with(name name: String) -> MySettings {
        return MySettings(greeting: greeting, name: name)
    }
    
    static let empty = MySettings(greeting: "", name: "")
}

class SettingsService {
    static let sharedService = SettingsService()
    
    private init() {}
    
    func saveSettings(settings: MySettings, completion: () -> ()) {
        let delay = dispatch_time(DISPATCH_TIME_NOW, (Int64)(3 * NSEC_PER_SEC))
        
        dispatch_after(delay, dispatch_get_main_queue()) {
            completion()
        }
    }
}