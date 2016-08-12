//
//  SwitchCell.swift
//  CotbDemo
//
//  Created by James Blair on 8/10/16.
//  Copyright © 2016 James Blair. All rights reserved.
//

import UIKit

// MARK: - SwitchCellDelegate
protocol SwitchCellDelegate: class {
    func switchWasToggled(sender: SwitchCell, on: Bool)
}


// MARK: - SwitchCell
@IBDesignable class SwitchCell: UITableViewCell, IdentifiableCellType {
    static let reuseIdentifier = "\(SwitchCell.self)"
    
    weak var delegate: SwitchCellDelegate?
    
    // MARK: Subviews
    lazy var label: UILabel = UILabel()
    lazy var toggleSwitch: UISwitch = UISwitch()
    
    
    // MARK: Initializers
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(label)
        contentView.addSubview(toggleSwitch)
        
        toggleSwitch.addTarget(self, action: #selector(toggleSwitchValueChanged), forControlEvents: .ValueChanged)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("\(#function) has not been implemented")
    }
    
    
    // MARK: Cell Lifecycle
    override func prepareForReuse() {
        super.prepareForReuse()
        delegate = nil
    }
    
    
    // MARK: Layout
    override func layoutSubviews() {
        super.layoutSubviews()
        
        var cellLayout = SwitchCellLayout(label: label, toggleSwitch: toggleSwitch)
        
        cellLayout.layout(in: contentView.bounds)
    }
    
    
    // MARK: Private
    @objc private func toggleSwitchValueChanged() {
        delegate?.switchWasToggled(self, on: toggleSwitch.on)
    }
}
