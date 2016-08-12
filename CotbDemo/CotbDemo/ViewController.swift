//
//  ViewController.swift
//  CotbDemo
//
//  Created by James Blair on 8/10/16.
//  Copyright © 2016 James Blair. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func startDemo(sender: PaddedBorderedButton) {
//        let viewController = UINavigationController(rootViewController: ComplicatedViewController())
        let viewController = UINavigationController(rootViewController: BetterViewController())
        
        presentViewController(viewController, animated: true, completion: nil)
    }

}

