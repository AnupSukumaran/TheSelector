//
//  PaddingLabel.swift
// 
//
//  Created by Anup Sukumaran on 20/10/18.
//  Copyright © 2018 WIS. All rights reserved.
//

import UIKit

@IBDesignable
public class PaddingLabel: UILabel {
    
    var topIn: CGFloat = 5.0
    var bottomIn: CGFloat = 5.0
    var leftIn: CGFloat = 5.0
    var rightIn: CGFloat = 5.0
    
    @IBInspectable public var topInset: CGFloat = 5.0 {
        didSet {
            topIn = topInset
        }
    }
    
    @IBInspectable public var bottomInset: CGFloat = 5.0  {
        didSet {
            bottomIn = bottomInset
        }
    }
    
    @IBInspectable public var leftInset: CGFloat = 5.0  {
        didSet {
            leftIn = leftInset
        }
    }
    
    @IBInspectable public var rightInset: CGFloat = 5.0 {
        didSet {
            rightIn = rightInset
        }
    }
    
    @IBInspectable public var cornurRadius: CGFloat = 1.0 {
        didSet {
            layer.cornerRadius = cornurRadius
            clipsToBounds = true
        }
    }
    
    @IBInspectable public var maskToBounds: Bool = false {
        didSet {
            layer.masksToBounds = maskToBounds
        }
    }
    
    public override var intrinsicContentSize: CGSize {
        get {
            var contentSize = super.intrinsicContentSize
            contentSize.height += topIn + bottomIn
            contentSize.width += leftIn + rightIn
            return contentSize
        }
    }
    
    override public func drawText(in rect: CGRect) {
        //frame = CGRect(x: 0, y: 0, width: frame.width + leftIn + rightIn, height: frame.height + topIn + bottomIn)
        let insets = UIEdgeInsets(top: topIn, left: leftIn , bottom: bottomIn, right: rightIn)
        super.drawText(in: rect.inset(by: insets))
    }
    
//    public override func invalidateIntrinsicContentSize() {
//        var intrinsicSuperViewContentSize = super.intrinsicContentSize
//        intrinsicSuperViewContentSize.height += topIn + bottomIn
//        intrinsicSuperViewContentSize.width += leftIn + rightIn
//        return intrinsicSuperViewContentSize
//    }
    
//     func intrinsicContentSize() -> CGSize {
//        var intrinsicSuperViewContentSize = super.intrinsicContentSize
//        intrinsicSuperViewContentSize.height += topIn + bottomIn
//        intrinsicSuperViewContentSize.width += leftIn + rightIn
//        return intrinsicSuperViewContentSize
//    }

//    public override func prepareForInterfaceBuilder() {
//        super.prepareForInterfaceBuilder()
//        layer.cornerRadius = cornurRadius
//    }
}
