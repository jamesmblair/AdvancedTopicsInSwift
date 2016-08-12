//
//  SwitchCellLayout.swift
//  CotbDemo
//
//  Created by James Blair on 8/11/16.
//  Copyright © 2016 James Blair. All rights reserved.
//

import UIKit

private let MARGIN: CGFloat = 8

struct SwitchCellLayout : Layout {
    private let label: UILabel
    private let toggleSwitch: UISwitch
    
    init(label: UILabel, toggleSwitch: UISwitch) {
        self.label = label
        self.toggleSwitch = toggleSwitch
    }
    
    mutating func layout(in rect: CGRect) {
        let insetBounds = rect.insetBy(dx: MARGIN, dy: MARGIN)
        
        let switchSize = toggleSwitch.intrinsicContentSize()
        
        let (switchMaxRect, labelMaxRect) = insetBounds.divide(switchSize.width, fromEdge: .MaxXEdge)
        
        let labelSize = label.sizeThatFits(labelMaxRect.size)
        
        let labelFrame = labelMaxRect.insetBy(dx: 0, dy: (insetBounds.height - labelSize.height) / 2)
        let switchFrame = switchMaxRect.insetBy(dx: 0, dy: (insetBounds.height - switchSize.height) / 2)
        
        label.layout(in: labelFrame)
        toggleSwitch.layout(in: switchFrame)
    }
}