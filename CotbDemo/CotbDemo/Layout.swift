//
//  Layout.swift
//  CotbDemo
//
//  Created by James Blair on 8/11/16.
//  Copyright © 2016 James Blair. All rights reserved.
//

import UIKit

protocol Layout {
    mutating func layout(in rect: CGRect)
}

extension UIView : Layout {
    func layout(in rect: CGRect) {
        frame = rect
    }
}

extension CALayer : Layout {
    func layout(in rect: CGRect) {
        frame = rect
    }
}