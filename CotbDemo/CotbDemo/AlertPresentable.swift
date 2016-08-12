//
//  AlertPresentable.swift
//  CotbDemo
//
//  Created by James Blair on 8/10/16.
//  Copyright © 2016 James Blair. All rights reserved.
//

import UIKit

protocol AlertPresentable {
    func presentAlert(message: String)
}

extension AlertPresentable where Self : UIViewController {
    func presentAlert(message: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .Alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
        
        presentViewController(alert, animated: true, completion: nil)
    }
}
