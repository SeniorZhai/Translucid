//
//  Translucid.swift
//  Translucid
//
//  Created by zhai on 16/7/26.
//  Copyright © 2016年 zhai. All rights reserved.
//

import UIKit

public class Translucid: UIView {

    private let textLayer: CATextLayer = CATextLayer()
    private let imageLayer: CALayer = CALayer()
    
    public var text:String = "Hello World" {
        didSet {
            self.textLayer.string = self.text
            self.autoResizeTextLayer()
        }
    }

    public var backgroundImage:UIImage?{
        didSet {
            if let image = backgroundImage {
                self.imageLayer.contents = image.CGImage
            }
        }
    }
    
    public override var frame: CGRect {
        didSet{
            self.imageLayer.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)
            self.textLayer.frame = self.bounds
            self.autoResizeTextLayer()
        }
    }
    
    public var font:UIFont = UIFont.boldSystemFontOfSize(20){
        didSet{
            self.textLayer.font = self.font
            self.autoResizeTextLayer()
        }
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    public required init?(coder aDecoder:NSCoder){
        super.init(coder: aDecoder)
        self.commonInit()
        
    }
    
    public func animate() {
        let animation:CABasicAnimation = CABasicAnimation(keyPath: "position")
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear);
        animation.fromValue = NSValue(CGPoint: self.imageLayer.position)
        animation.toValue = NSValue(CGPoint: CGPointMake(self.imageLayer.position.x, self.imageLayer.position.y - 200))
        animation.duration = 15.0
        animation.autoreverses = true
        animation.repeatCount = Float.infinity
        
        self.imageLayer.addAnimation(animation, forKey: "transform")
    }
    
    private func autoResizeTextLayer(){
        var fontSize:CGFloat = 1.0
        var rect:CGRect = NSString(string:self.text).boundingRectWithSize(CGSizeMake(self.bounds.width,CGFloat(MAXFLOAT)), options: .UsesLineFragmentOrigin, attributes: [NSFontAttributeName: self.font.fontWithSize(fontSize)], context: nil)
        
        while rect.size.height < self.bounds.size.height {
            fontSize++
            rect = NSString(string:self.text).boundingRectWithSize(CGSizeMake(self.bounds.width,CGFloat(MAXFLOAT)), options: .UsesLineFragmentOrigin, attributes: [NSFontAttributeName: self.font.fontWithSize(fontSize)], context: nil)
        }
        
        --fontSize
        self.textLayer.fontSize = fontSize
        self.textLayer.font = self.font.fontWithSize(fontSize)
    }
    
    private func commonInit(){
        self.textLayer.string = self.text
        self.textLayer.alignmentMode = kCAAlignmentCenter
        self.textLayer.frame = self.bounds
        self.textLayer.fontSize = 0.0
        self.textLayer.font = self.font
        self.textLayer.wrapped = true
        self.textLayer.rasterizationScale = UIScreen.mainScreen().scale
        self.textLayer.truncationMode = kCATruncationEnd
        self.textLayer.contentsScale = UIScreen.mainScreen().scale
        
        self.autoResizeTextLayer()
        
        self.layer.addSublayer(self.imageLayer)
        self.layer.mask = self.textLayer
    }
    
}
