//
//  PaddedBorderedButton.swift
//  CotbDemo
//
//  Created by James Blair on 8/10/16.
//  Copyright © 2016 James Blair. All rights reserved.
//

import UIKit

@IBDesignable
public class PaddedBorderedButton : UIButton {
    
    @IBInspectable
    public var horizontalPadding: CGFloat = 10 {
        didSet { invalidateIntrinsicContentSize() }
    }
    
    @IBInspectable
    public var borderWidth: CGFloat = 1 {
        didSet { layer.borderWidth = borderWidth }
    }
    
    @IBInspectable
    public var borderColor: UIColor = .clearColor() {
        didSet { layer.borderColor = borderColor.CGColor }
    }
    
    public override func intrinsicContentSize() -> CGSize {
        let baseSize = super.intrinsicContentSize()
        
        return CGSize(
            width: baseSize.width + (2 * horizontalPadding),
            height: baseSize.height
        )
    }
}
