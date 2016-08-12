//
//  BetterViewController.swift
//  CotbDemo
//
//  Created by James Blair on 8/10/16.
//  Copyright © 2016 James Blair. All rights reserved.
//

import UIKit
import MBProgressHUD

class BetterViewController : UITableViewController {
    override func loadView() {
        tableView = UITableView(frame: CGRect.zero, style: .Grouped)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationItem()
        
        tableView.registerClass(SwitchCell.self, forCellReuseIdentifier: SwitchCell.reuseIdentifier)
        tableView.registerClass(TextEntryCell.self, forCellReuseIdentifier: TextEntryCell.reuseIdentifier)
        tableView.registerClass(ButtonCell.self, forCellReuseIdentifier: ButtonCell.reuseIdentifier)
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        fatalError("Not implemented")
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        fatalError("Not implemented")
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        fatalError("Not implemented")
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        fatalError("Not implemented")
    }
    
    override func tableView(tableView: UITableView, shouldHighlightRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        fatalError("Not implemented")
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        fatalError("Not implemented")
    }
    
    private func configureNavigationItem() {
        title = "Demo"
        
        navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.whiteColor()]
        navigationController!.navigationBar.barTintColor = cotbOrangeColor
        navigationController!.navigationBar.translucent = false
        
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .Cancel, target: self, action: #selector(cancel))
        cancelButton.setTitleTextAttributes([NSForegroundColorAttributeName:UIColor.whiteColor()], forState: .Normal)
        
        navigationItem.leftBarButtonItem = cancelButton
    }
    
    private var cotbOrangeColor: UIColor {
        return presentingViewController!.view.backgroundColor!
    }
    
    @objc private func cancel() {
        dismissViewControllerAnimated(true, completion: nil)
    }
}


// MARK: - BetterViewController (SwitchCellDelegate)
extension BetterViewController : SwitchCellDelegate {
    func switchWasToggled(sender: SwitchCell, on: Bool) {
        fatalError("Not implemented")
    }
}


// MARK: - BetterViewController (TextEntryCellDelegate)
extension BetterViewController : TextEntryCellDelegate {
    func textDidChange(sender: TextEntryCell, text: String) {
        fatalError("Not implemented")
    }
}


// MARK: - BetterViewController (ButtonCellDelegate)
extension BetterViewController : ButtonCellDelegate {
    func buttonWasPressed(sender: ButtonCell) {
        fatalError("Not implemented")
    }
}


