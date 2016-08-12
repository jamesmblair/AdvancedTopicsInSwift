//
//  TextEntryCellLayout.swift
//  CotbDemo
//
//  Created by James Blair on 8/11/16.
//  Copyright © 2016 James Blair. All rights reserved.
//

import UIKit

struct TextEntryCellLayout : Layout {
    private let textField: UITextField
    private let activityIndicator: UIActivityIndicatorView
    
    init(textField: UITextField, activityIndicator: UIActivityIndicatorView) {
        self.textField = textField
        self.activityIndicator = activityIndicator
    }
    
    mutating func layout(in rect: CGRect) {
        let insetBounds = rect.insetBy(dx: 8, dy: 8)
        
        let activitySize = activityIndicator.intrinsicContentSize()
        let (activityMaxRect, textFieldMaxRect) = insetBounds.divide(activitySize.width, fromEdge: .MaxXEdge)
        let textFieldSize = textField.sizeThatFits(textFieldMaxRect.size)
        
        let textFieldFrame = textFieldMaxRect.insetBy(dx: 0, dy: (insetBounds.height - textFieldSize.height) / 2)
        let activityIndicatorFrame = activityMaxRect.insetBy(dx: 0, dy: (insetBounds.height - activitySize.height) / 2)
        
        textField.layout(in: textFieldFrame)
        activityIndicator.layout(in: activityIndicatorFrame)
    }
}
