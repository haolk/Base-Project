//
//  Extension+UIView.swift
//  BaseProject
//
//  Created by Rohit Makwana on 07/06/19.
//  Copyright © 2019 Rohit Makwana. All rights reserved.
//

import Foundation
import UIKit


public enum AIEdge:Int {
    
    case
    Top,
    Left,
    Bottom,
    Right,
    Top_Left,
    Top_Right,
    Bottom_Left,
    Bottom_Right,
    All,
    None
}


extension UIView {
    
    //=======================================================================
    // Creates a `UIView` From NIB
    //
    // - returns: The created `UIView`.
    //=======================================================================
    static func instantiateFromNib() -> Self? {
        
        func instanceFromNib<T: UIView>() -> T? {
            return UINib(nibName: "\(self)", bundle: nil).instantiate(withOwner: nil, options: nil).first as? T
        }
        return instanceFromNib()
    }
    
    //=======================================================================
    // Creates a `UIView` From NIB
    //
    // - returns: The created `UIView`.
    //=======================================================================

    
    func loadViewFromNib() -> UIView! {
        
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        return view
    }
    
    // MARK:- HEIGHT / WIDTH
    
    var width:CGFloat {
        return self.frame.size.width
    }
    var height:CGFloat {
        return self.frame.size.height
    }
    var xPos:CGFloat {
        return self.frame.origin.x
    }
    var yPos:CGFloat {
        return self.frame.origin.y
    }
    
    
    // MARK:- ROTATE
    func rotate(angle: CGFloat) {
        
        let radians = angle / 180.0 * CGFloat(Double.pi)
        self.transform = self.transform.rotated(by: radians);
    }
    
    // MARK:- BORDER
    func applyBorder(color:UIColor, width:CGFloat) {
        
        self.layer.borderColor = color.cgColor
        self.layer.borderWidth = width
    }
    
    
    //=======================================================================
    // Creates a `Circle` of UIView
    //=======================================================================

    func applyCircle() {
        
        self.layer.cornerRadius  = min(self.frame.size.height, self.frame.size.width) * 0.5
        self.layer.masksToBounds = false
        self.clipsToBounds = true
    }
    
    
    // MARK:- CORNER RADIUS
    //=======================================================================
    // Creates a `Corner Radius` using the default `radius`.
    // `radius`.
    //
    // - parameter radius:             The radius.
    //
    //=======================================================================

    func applyCornerRadius(With radius:CGFloat) {
        
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }
    
    //=======================================================================
    // Creates a `Corner Radius` using the default `corners` and `radius`.
    // `corners` and `radius`.
    //
    // - parameter corners:             The corners.
    // - parameter radius:             The radius.
    //
    //=======================================================================

    
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
    
    
    //=======================================================================
    // Creates `Shadow` with default color
    //=======================================================================
    
    func applyShadowDefault() {
        
        self.applyShadowWithColor(color: UIColor.black, opacity: 0.5, radius: 1)
    }
    
    //=======================================================================
    // Creates `Shadow` with color
    //=======================================================================

    func applyShadowWithColor(color:UIColor) {
        
        self.applyShadowWithColor(color: color, opacity: 0.5, radius: 1)
    }
    
    //=======================================================================
    // Creates a `Shadow` using the default `color`, `opacity` and `radius`.
    // `color`, `opacity` and `radius`.
    //
    // - parameter color:             The color.
    // - parameter opacity:           The opacity.
    // - parameter radius:            The radius.
    //
    //=======================================================================
    
    func applyShadowWithColor(color: UIColor, opacity:Float, radius: CGFloat) {
        
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOpacity = opacity
        self.layer.shadowOffset = CGSize.zero
        self.layer.shadowRadius = radius
        self.clipsToBounds = false
    }
    
    
    //=======================================================================
    // Creates a `Shadow` using the default `color`, `opacity`, `radius`, `edge` and `shadowSpace`.
    // `color`, `opacity`, `radius`, `edge` and `shadowSpace`.
    //
    // - parameter color:             The color.
    // - parameter opacity:           The opacity.
    // - parameter radius:            The radius.
    // - parameter edge:              The edge.
    // - parameter shadowSpace:       The shadowSpace.
    //
    //=======================================================================

    func applyShadowWithColor(color:UIColor, opacity:Float, radius: CGFloat, edge:AIEdge, shadowSpace:CGFloat)  {
        
        var sizeOffset:CGSize = CGSize.zero
        switch edge {
        case .Top:
            sizeOffset = CGSize(width: 0, height: -shadowSpace) //CGSizeMake(0, -shadowSpace)
        case .Left:
            sizeOffset = CGSize(width: -shadowSpace, height: 0) //CGSizeMake(-shadowSpace, 0)
        case .Bottom:
            sizeOffset = CGSize(width: 0, height: shadowSpace) //CGSizeMake(0, shadowSpace)
        case .Right:
            sizeOffset = CGSize(width: shadowSpace, height: 0) //CGSizeMake(shadowSpace, 0)
            
            
        case .Top_Left:
            sizeOffset = CGSize(width: -shadowSpace, height: -shadowSpace) //CGSizeMake(-shadowSpace, -shadowSpace )
        case .Top_Right:
            sizeOffset = CGSize(width: shadowSpace, height: -shadowSpace) //CGSizeMake(shadowSpace, -shadowSpace)
        case .Bottom_Left:
            sizeOffset = CGSize(width: -shadowSpace, height: shadowSpace) //CGSizeMake(-shadowSpace, shadowSpace)
        case .Bottom_Right:
            sizeOffset = CGSize(width: shadowSpace, height: shadowSpace) //CGSizeMake(shadowSpace, shadowSpace)
        case .All:
            sizeOffset = CGSize(width: 0, height: 0) //CGSizeMake(0, 0)
        case .None:
            sizeOffset = CGSize.zero
        }
        
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOpacity = opacity
        self.layer.shadowOffset = sizeOffset
        self.layer.shadowRadius = radius
        self.clipsToBounds = false
    }
    
    //=======================================================================
    // Creates a `Shadow` using the default `color`, `edge` and `thickness`.
    // `color`, `edge` and `shadowSpace`.
    //
    // - parameter color:             The color.
    // - parameter edge:              The edge.
    // - parameter thickness:         The thickness.
    //
    //=======================================================================

    
    func addBorderWithColor(color: UIColor, edge: AIEdge, ThicknessOfBorder thickness: CGFloat)  {
        
        DispatchQueue.main.async {
            
            var rect:CGRect = CGRect.zero
            
            switch edge {
            case .Top:
                rect = CGRect(x: 0, y: 0, width: self.width, height: thickness) //CGRectMake(0, 0, self.width, thicknessOfBorder);
            case .Left:
                rect = CGRect(x: 0, y: 0, width: thickness, height:self.width ) //CGRectMake(0, 0, thicknessOfBorder, self.height);
            case .Bottom:
                rect = CGRect(x: 0, y: self.height - thickness, width: self.width, height: thickness) //CGRectMake(0, self.height - thicknessOfBorder, self.width, thicknessOfBorder);
            case .Right:
                rect = CGRect(x: self.width-thickness, y: 0, width: thickness, height: self.height) //CGRectMake(self.width-thicknessOfBorder, 0,thicknessOfBorder, self.height);
            default:
                break
            }
            
            let layerBorder = CALayer()
            layerBorder.frame = rect
            layerBorder.backgroundColor = color.cgColor
            self.layer.addSublayer(layerBorder)
        }
    }
    
    
    //=======================================================================
    // Creates a `Shadow` using the default `color`, `edge` and `thickness`.
    // `color`, `edge` and `shadowSpace`.
    //
    // - parameter color:             The color.
    // - parameter opacity:           The opacity. `0.6` by Default
    // - parameter offSet:            The offSet.
    // - parameter radius:            The radius. `5.0` by Default
    // - parameter scale:             The scale. `true` by Default
    //
    //=======================================================================

    func addShadow(color: UIColor, opacity: Float = 0.6, offSet: CGSize, radius: CGFloat = 5.0, scale: Bool = true) {
        
        self.layer.masksToBounds = false
        
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOpacity = opacity
        self.layer.shadowOffset = offSet
        self.layer.shadowRadius = radius
        self.layer.cornerRadius = 3.0
    }
    
    
    //=======================================================================
    // Creates a `Gradient` using the default `colors.
    // `colors``.
    //
    // - parameter colors:          The colors.
    //
    //=======================================================================

    func applyGradientWith(_ colors : [CGColor]) {
        
        let gradient = CAGradientLayer()
        gradient.colors = colors
        gradient.locations = [0.0, 0.5, 1.0]
        gradient.frame = self.bounds
        self.layer.insertSublayer(gradient, at: 0)
    }
    
    
    //=======================================================================
    // Creates a `Layout` using the default `cornerRadius`, `borderColor` and `borderWidth`.
    // `cornerRadius`, `borderColor` and `borderWidth`.
    //
    // - parameter cornerRadius:          The cornerRadius.
    // - parameter borderColor:           The borderColor.
    // - parameter borderWidth:           The borderWidth.
    //
    //=======================================================================

    func setLayout(cornerRadius: CGFloat , borderColor: UIColor, borderWidth: CGFloat) {
        
        self.layer.cornerRadius  = cornerRadius
        self.layer.borderColor   = borderColor.cgColor
        self.layer.borderWidth   = borderWidth
        self.layer.masksToBounds = true
    }
    
    
    //=======================================================================
    // Creates a `Gradient Color` using the default `topColor`, `bottomColor`, `size` and `direction`.
    // `topColor`, `bottomColor`, `size` and `direction`.
    //
    // - parameter topColor:          The topColor
    // - parameter bottomColor:       The bottomColor.
    // - parameter size:              The size.
    // - parameter direction:         The direction.
    //
    // - returns: The created `UIColor`.
    //=======================================================================
    
    func getGradientColorImage(WithTopColor topColor: UIColor, andBottomColor bottomColor: UIColor, ForSize size: CGSize, toDirection direction: GradientDirectionType) -> UIColor {
        
        UIGraphicsBeginImageContextWithOptions(size, false, 0);
        let context = UIGraphicsGetCurrentContext();
        let colorspace = CGColorSpaceCreateDeviceRGB();
        
        let colors = [topColor.cgColor, bottomColor.cgColor] as CFArray;
        let gradient = CGGradient(colorsSpace: colorspace, colors: colors, locations: nil);
        
        if context == nil {  return topColor }
        
        if direction == .leftToRight {
            
            context!.drawLinearGradient(gradient!, start: CGPoint(x:0, y:0), end: CGPoint(x:size.width, y:0), options: CGGradientDrawingOptions(rawValue: UInt32(0)));
        }
        else if direction == .leftCornerToRightCorner {
            
            context!.drawLinearGradient(gradient!, start: CGPoint(x:0, y:0), end: CGPoint(x:size.width, y:size.height), options: CGGradientDrawingOptions(rawValue: UInt32(0)));
        }
        else {
            
            context!.drawLinearGradient(gradient!, start: CGPoint(x:0, y:0), end: CGPoint(x:0, y:size.height), options: CGGradientDrawingOptions(rawValue: UInt32(0)));
        }
        
        let image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        return UIColor(patternImage: image!)
    }
}


