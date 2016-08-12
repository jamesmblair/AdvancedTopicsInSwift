//
//  ButtonCell.swift
//  CotbDemo
//
//  Created by James Blair on 8/10/16.
//  Copyright © 2016 James Blair. All rights reserved.
//

import UIKit

import UIKit


// MARK: - ButtonCellDelegate
protocol ButtonCellDelegate: class {
    func buttonWasPressed(sender: ButtonCell)
}


// MARK: - ButtonCell
@IBDesignable class ButtonCell: UITableViewCell, IdentifiableCellType {
    static let reuseIdentifier = "\(ButtonCell.self)"
    
    weak var delegate: ButtonCellDelegate?
    
    // MARK: Subviews
    lazy var button: UIButton = UIButton()
    
    
    // MARK: Initializers
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(button)
        
        button.addTarget(self, action: #selector(buttonWasPressed), forControlEvents: .TouchUpInside)
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
        
        button.layout(in: contentView.bounds)
    }
    
    @objc private func buttonWasPressed() {
        delegate?.buttonWasPressed(self)
    }
}
