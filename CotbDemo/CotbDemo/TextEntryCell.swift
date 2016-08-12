//
//  TextEntryCell.swift
//  CotbDemo
//
//  Created by James Blair on 8/10/16.
//  Copyright © 2016 James Blair. All rights reserved.
//

import UIKit


// MARK: - ProfileFundraisingEmailCellDelegate
protocol TextEntryCellDelegate: class {
    func textDidChange(sender: TextEntryCell, text: String)
}


// MARK: - ProfileFundraisingEmailCell
@IBDesignable class TextEntryCell: UITableViewCell, IdentifiableCellType {
    static let reuseIdentifier = "\(TextEntryCell.self)"
    
    weak var delegate: TextEntryCellDelegate?
    
    // MARK: Subviews
    lazy var textField: UITextField = UITextField()
    lazy var activityIndicator: UIActivityIndicatorView = {
        let v = UIActivityIndicatorView()
        v.hidesWhenStopped = true
        return v
    }()
    
    
    // MARK: Initializers
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(textField)
        contentView.addSubview(activityIndicator)
        
        textField.addTarget(self, action: #selector(textFieldChanged), forControlEvents: .EditingChanged)
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
        
        var cellLayout = TextEntryCellLayout(textField: textField, activityIndicator: activityIndicator)
        
        cellLayout.layout(in: contentView.bounds)
    }
    
    
    // MARK: Private
    @objc private func textFieldChanged() {
        delegate?.textDidChange(self, text: textField.text ?? "")
    }
}