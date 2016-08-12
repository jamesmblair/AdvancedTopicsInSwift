//
//  ComplicatedViewController.swift
//  CotbDemo
//
//  Created by James Blair on 8/10/16.
//  Copyright © 2016 James Blair. All rights reserved.
//

import UIKit
import MBProgressHUD

class ComplicatedViewController : UITableViewController {
    var featureIsEnabled: Bool = false
    var greeting: String = ""
    var name: String = ""
    
    var isValid: Bool {
        return !greeting.isEmpty
            && !name.isEmpty
    }
    
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
        if !featureIsEnabled {
            return 1
        } else {
            if !isValid {
                return 2
            } else {
                return 3
            }
        }
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return 1 // "Switch" row
        case 1: return 2 // Data entry rows
        case 2: return 1 // Submit button row
        default: fatalError("Invalid section index.")
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell: SwitchCell = safeGetCell(for: tableView, at: indexPath)
            cell.label.text = "Enable a Cool Feature?"
            cell.toggleSwitch.onTintColor = cotbOrangeColor
            cell.toggleSwitch.on = featureIsEnabled
            cell.delegate = self
            return cell
        case 1:
            let cell: TextEntryCell = safeGetCell(for: tableView, at: indexPath)
            
            switch indexPath.row {
            case 0:
                cell.textField.placeholder = "Greeting"
                cell.textField.text = greeting
                cell.delegate = self
            case 1:
                cell.textField.placeholder = "Name"
                cell.textField.text = name
                cell.delegate = self
            default: fatalError("Invalid row index.")
            }
            
            return cell
        case 2:
            let cell: ButtonCell = safeGetCell(for: tableView, at: indexPath)
            cell.button.setTitle("Submit", forState: .Normal)
            cell.button.setTitleColor(cotbOrangeColor, forState: .Normal)
            cell.button.setTitleColor(cotbOrangeColor.colorWithAlphaComponent(0.3), forState: .Disabled)
            cell.delegate = self
            return cell
        default: fatalError("Invalid section index.")
        }
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 1 {
            return "Configure the Cool Feature"
        }
        return nil
    }
    
    override func tableView(tableView: UITableView, shouldHighlightRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return indexPath.section != 2
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        switch indexPath.section {
            
        case 0:
            let cell = tableView.cellForRowAtIndexPath(indexPath) as! SwitchCell
            cell.toggleSwitch.on = !cell.toggleSwitch.on
            switchWasToggled(cell, on: cell.toggleSwitch.on)
            
        case 1:
            let cell = tableView.cellForRowAtIndexPath(indexPath) as! TextEntryCell
            cell.textField.becomeFirstResponder()
        
        default: fatalError("Invalid section index.")
        }
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
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


// MARK: - ComplicatedViewController (SwitchCellDelegate)
extension ComplicatedViewController : SwitchCellDelegate {
    func switchWasToggled(sender: SwitchCell, on: Bool) {
        featureIsEnabled = on
        
        if on {
            tableView.insertSections(NSIndexSet(index: 1), withRowAnimation: .Middle)
        } else {
            tableView.deleteSections(NSIndexSet(index: 1), withRowAnimation: .Middle)
        }
    }
}


// MARK: - ComplicatedViewController (TextEntryCellDelegate)
extension ComplicatedViewController : TextEntryCellDelegate {
    func textDidChange(sender: TextEntryCell, text: String) {
        guard let indexPath = tableView.indexPathForCell(sender)
            else { return }
        
        switch indexPath.row {
        case 0: greeting = text
        case 1: name = text
        default: fatalError("Invalid row index.")
        }
        
        if isValid && tableView.numberOfSections == 2 {
            tableView.insertSections(NSIndexSet(index: 2), withRowAnimation: .Middle)
        } else if !isValid && tableView.numberOfSections == 3 {
            tableView.deleteSections(NSIndexSet(index: 2), withRowAnimation: .Middle)
        }
    }
}


// MARK: - ComplicatedViewController (ButtonCellDelegate)
extension ComplicatedViewController : ButtonCellDelegate {
    func buttonWasPressed(sender: ButtonCell) {
        let hud = MBProgressHUD.showHUDAddedTo(view, animated: true)
        
        let settings = MySettings(greeting: greeting, name: name)
        
        SettingsService.sharedService.saveSettings(settings) {
            hud.hideAnimated(true)
            
            let alert = UIAlertController(
                title: nil, 
                message: "\(self.greeting), \(self.name)!",
                preferredStyle: .Alert
            )
            
            alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
            
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
}


