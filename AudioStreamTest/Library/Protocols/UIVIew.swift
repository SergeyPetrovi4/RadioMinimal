//
//  UIVIewExtension.swift
//  MOEStudents
//
//  Created by Sergey Krasiuk on 21/05/2017.
//  Copyright © 2017 IdeoDigital. All rights reserved.
//

import UIKit

protocol Shadowed {}
protocol XibInstantiable {}
protocol Rounded {}
protocol Renderable {}

extension Shadowed where Self: UIView {
    
    // MARK: Drop Shadow for View
    
    func dropShadowWith(offset: CGSize,
                        radius: CGFloat,
                        opacity: Float,
                        color: UIColor = UIColor.black,
                        clipsToBound: Bool = false, shouldRisterize: Bool = true) {
        
        self.layer.shadowOffset = offset
        self.layer.shadowColor = color.cgColor
        self.layer.shadowRadius = radius
        self.layer.shadowOpacity = opacity
        self.layer.shouldRasterize = shouldRisterize
        self.layer.rasterizationScale = UIScreen.main.scale

        self.clipsToBounds = clipsToBounds
    }
}

extension Rounded where Self: UIView {
    
    // MARK: Custom rounded corners for View
    
    func setRoundedCorners(radius: CGFloat) {
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }
    
    func setRounded(corners: UIRectCorner, radius: CGSize) {
        
        let maskPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: radius)
        let layer = CAShapeLayer()
        
        layer.frame = self.bounds
        layer.path = maskPath.cgPath
        
        self.layer.mask = layer
        self.layer.masksToBounds = false
    }
}

extension XibInstantiable where Self: UIView {
    
    // MARK: Instantiate custom view from xib
    
    func xibinstantiate() -> UIView {
        
        let view = self.instantiateViewFromXib()
        view.frame = self.bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        return view
    }
    
    func instantiateViewFromXib() -> UIView {
        
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        
        return view
    }
}

class ShadowedView: UIView, Shadowed, Rounded {}
class RoundedView: UIView, Rounded {}

extension Renderable where Self: UIView {
    
    func render() -> UIImage {
    
        if #available(iOS 10.0, *) {
            
            let renderer = UIGraphicsImageRenderer(size: self.bounds.size)
            let image = renderer.image { ctx in
                self.drawHierarchy(in: self.bounds, afterScreenUpdates: true)
            }
            
            return image
            
        } else {
            
            UIGraphicsBeginImageContext(self.bounds.size)
            self.layer.render(in:UIGraphicsGetCurrentContext()!)
            let image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            return image!
        }
    }
}

