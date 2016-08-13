//
//  BetterViewController.swift
//  CotbDemo
//
//  Created by James Blair on 8/10/16.
//  Copyright © 2016 James Blair. All rights reserved.
//

import UIKit
import MBProgressHUD

private enum Section {
    case Switch
    case TextEntry
    case SubmitButton
}

private enum ViewState {
    case Disabled
    case Invalid(settings: MySettings)
    case Valid(settings: MySettings)
    case Submitting(settings: MySettings)
    
    var enabled: Bool {
        if case .Disabled = self {
            return false
        } else {
            return true
        }
    }
    
    var settings: MySettings? {
        switch self {
        case .Invalid(let settings): return settings
        case .Valid(let settings): return settings
        case .Submitting(let settings): return settings
        default: return nil
        }
    }
    
    init(settings: MySettings) {
        if settings.greeting.isEmpty || settings.name.isEmpty {
            self = .Invalid(settings: settings)
        } else {
            self = .Valid(settings: settings)
        }
    }
}

class BetterViewController : UITableViewController, AlertPresentable {
    private var viewState: ViewState = .Disabled {
        didSet { transitionState(oldValue, viewState) }
    }
    
    private var activeSections: [Section] {
        switch viewState {
        case .Disabled: return [.Switch]
        case .Invalid: return [.Switch, .TextEntry]
            
        case .Valid: fallthrough
        case .Submitting: return [.Switch, .TextEntry, .SubmitButton]
        }
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
        return activeSections.count
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch activeSections[section] {
        case .Switch: fallthrough
        case .SubmitButton: return 1
        case .TextEntry: return 2
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        switch activeSections[indexPath.section] {
        case .Switch:
            let cell: SwitchCell = safeGetCell(for: tableView, at: indexPath)
            cell.label.text = "Enable a Cool Feature?"
            cell.toggleSwitch.onTintColor = cotbOrangeColor
            cell.toggleSwitch.on = viewState.enabled
            cell.delegate = self
            return cell
            
        case .TextEntry:
            guard let settings = viewState.settings
                else { fatalError("Invalid state.") }
            
            let cell: TextEntryCell = safeGetCell(for: tableView, at: indexPath)
            
            switch indexPath.row {
            case 0:
                cell.textField.placeholder = "Greeting"
                cell.textField.text = settings.greeting
                cell.delegate = self
            case 1:
                cell.textField.placeholder = "Name"
                cell.textField.text = settings.name
                cell.delegate = self
            default: fatalError("Invalid row index.")
            }
            
            return cell
            
        case .SubmitButton:
            let cell: ButtonCell = safeGetCell(for: tableView, at: indexPath)
            cell.button.setTitle("Submit", forState: .Normal)
            cell.button.setTitleColor(cotbOrangeColor, forState: .Normal)
            cell.button.setTitleColor(cotbOrangeColor.colorWithAlphaComponent(0.3), forState: .Disabled)
            cell.delegate = self
            return cell
            
        }
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if case .TextEntry = activeSections[section] {
            return "Configure the Cool Feature"
        }
        return nil
    }
    
    override func tableView(tableView: UITableView, shouldHighlightRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        if case .SubmitButton = activeSections[indexPath.section] {
            return false
        }
        return true
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        switch activeSections[indexPath.section] {
        case .Switch:
            let cell = tableView.cellForRowAtIndexPath(indexPath) as! SwitchCell
            cell.toggleSwitch.on = !cell.toggleSwitch.on
            switchWasToggled(cell, on: cell.toggleSwitch.on)
            
        case .TextEntry:
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
    
    private func transitionState(oldState: ViewState, _ newState: ViewState) {
        switch (oldState, newState) {
        // Ignore "self" transitions
        case (.Disabled, .Disabled): fallthrough
        case (.Invalid, .Invalid): fallthrough
        case (.Valid, .Valid): fallthrough
        case (.Submitting, .Submitting): return
            
        // From 'Disabled'
        case (.Disabled, .Invalid):
            tableView.insertSections(NSIndexSet(index: 1), withRowAnimation: .Middle)
            
        // From 'Invalid'
        case (.Invalid, .Disabled):
            tableView.deleteSections(NSIndexSet(index: 1), withRowAnimation: .Middle)
        case (.Invalid, .Valid):
            tableView.insertSections(NSIndexSet(index: 2), withRowAnimation: .Middle)
            
        // From 'Valid'
        case (.Valid, .Disabled):
            tableView.deleteSections(NSIndexSet(indexesInRange: NSRange(1...2)), withRowAnimation: .Middle)
        case (.Valid, .Invalid):
            tableView.deleteSections(NSIndexSet(index: 2), withRowAnimation: .Middle)
        case (.Valid, .Submitting):
            MBProgressHUD.showHUDAddedTo(view, animated: true)
            
        // From 'Submitting'
        case (.Submitting, .Valid):
            MBProgressHUD.hideHUDForView(view, animated: true)
            
        default: fatalError("Invalid state transition.")
        }
    }
}


// MARK: - BetterViewController (SwitchCellDelegate)
extension BetterViewController : SwitchCellDelegate {
    func switchWasToggled(sender: SwitchCell, on: Bool) {
        viewState = on ? .Invalid(settings: .empty) : .Disabled
    }
}


// MARK: - BetterViewController (TextEntryCellDelegate)
extension BetterViewController : TextEntryCellDelegate {
    func textDidChange(sender: TextEntryCell, text: String) {
        
        guard let indexPath = tableView.indexPathForCell(sender)
            else { return }
        guard let settings = viewState.settings
            else { fatalError("Invalid state.") }
        
        switch indexPath.row {
        case 0: viewState = ViewState(settings: settings.with(greeting: text))
        case 1: viewState = ViewState(settings: settings.with(name: text))
        default: fatalError("Invalid row index.")
        }
    }
}


// MARK: - BetterViewController (ButtonCellDelegate)
extension BetterViewController : ButtonCellDelegate {
    func buttonWasPressed(sender: ButtonCell) {
        
        guard let settings = viewState.settings
            else { fatalError("Invalid state.") }
        
        SettingsService.sharedService.saveSettings(settings) {
            self.presentAlert("\(settings.greeting), \(settings.name)!")
        }
    }
}


