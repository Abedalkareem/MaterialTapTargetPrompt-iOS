//
//  MaterialTapTargetPrompt.swift
//  MaterialTapTargetPrompt
//
//  Created by abedalkareem omreyh on 1/24/17.
//  Copyright © 2017 abedalkareem omreyh. All rights reserved.
//  GitHub : https://github.com/Abedalkareem/MaterialTapTargetPrompt-iOS
//
//  The MIT License (MIT)
//
//  Copyright (c) 2017 Abedalkareem Omreyh
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.
//

import UIKit

public class MaterialTapTargetPrompt: UIView {
    
    // MARK: Private properties
    fileprivate var targetView: UIView!
    private let coloredCircleLayer = CAShapeLayer()
    private let blurWhiteCircleLayer = CAShapeLayer()
    
    fileprivate var type: Type!
    private let sizeOfView: CGFloat!
    private var spaceBetweenLabel: CGFloat = 10.0
    
    private var primaryTextLabel: UILabel!
    private var secondaryTextLabel: UILabel!
    private var dummyView: UIView?
    private let appWindow = UIApplication.shared.keyWindow
    
    // MARK: Public properties
    /// The primary label font
    @objc public var primaryFont: UIFont?
    /// The secondary label font
    @objc public var secondaryFont: UIFont?
    
    /// The action will run when the target clicked.
    @objc public var action: (() -> Void) = {}
    /// The action will run when out of the target clicked.
    @objc public var dismissed: (() -> Void) = {}
    
    /// The primary text.
    @objc public var primaryText: String = "Primary text Here !" {
        willSet{
            primaryTextLabel.text = newValue
            primaryTextLabel.sizeToFit()
        }
    }
    
    /// The secondary text.
    @objc public var secondaryText: String = "Secondary text Here !" {
        willSet{
            secondaryTextLabel.text = newValue
            secondaryTextLabel.sizeToFit()
        }
    }
    
    /// The circel color. `.blue` by default.
    @objc public var circleColor: UIColor! = UIColor.blue {
        willSet{
            coloredCircleLayer.fillColor = newValue.cgColor
        }
    }
    
    /// The text postion around the view. `.bottomRight` by default
    @objc public var textPostion: TextPostion = .bottomRight {
        willSet {
            var xPostion: CGFloat = 0.0
            var yPostion: CGFloat = 0.0
            
            let viewWidth = self.frame.width
            // set y and x postion
            switch newValue {
            case .bottomRight:
                xPostion = viewWidth/1.9
                yPostion = viewWidth/1.6
            case .bottomLeft:
                xPostion = viewWidth/4
                yPostion = viewWidth/1.6
            case .topRight:
                xPostion = viewWidth/1.9
                yPostion = viewWidth/4
            case .topLeft:
                xPostion = viewWidth/4
                yPostion = viewWidth/4
            case .centerRight:
                xPostion = viewWidth/1.6
                yPostion = viewWidth/2.23
            case .centerLeft:
                xPostion = viewWidth/6
                yPostion = viewWidth/2.23
            case .cenertTop:
                xPostion = viewWidth/2.23
                yPostion = viewWidth/1.6
            case .centerBottom:
                xPostion = viewWidth/2.23
                yPostion = viewWidth/1.6
            }
            
            // reposition labels
            primaryTextLabel.frame = CGRect(x: xPostion, y: yPostion, width: primaryTextLabel.frame.width, height: primaryTextLabel.frame.height)
            secondaryTextLabel.frame = CGRect(x: xPostion, y: primaryTextLabel.frame.height+primaryTextLabel.frame.origin.y+spaceBetweenLabel, width: secondaryTextLabel.frame.width, height: secondaryTextLabel.frame.height)
        }
    }
    
    // MARK: init
    
    ///
    /// Creates an instance with the target view and the type of shape.
    ///
    /// -parameter target: The view that you want to show the prompt around.
    /// -parameter type: Type of shape of the view, `.circle` by default.
    ///
    /// -returns: new MaterialTapTargetPrompt instance.
    @objc public init(target targetView: NSObject, type: Type = .circle) {
        self.sizeOfView = appWindow!.frame.width * 2 // set size of view
        super.init(frame: CGRect(x: 0, y: 0, width: sizeOfView, height: sizeOfView))
        self.type = type
        
        self.targetView = getTargetView(object: targetView) // get the view from the sended target
        backgroundColor = UIColor.clear // make background of view clear
        
        
        let convertedFrame = self.targetView.convert(self.targetView.bounds, to: appWindow)
        self.center = CGPoint(x: convertedFrame.origin.x + convertedFrame.width/2 , y: convertedFrame.origin.y + convertedFrame.height/2) //center view
        
        appWindow?.addSubview(self) // add to window
        
        drawColoredCircle()
        drawBlurWhiteCircle()
        addText()
        
        // dummy view used to hide the MaterialTapTargetPrompt view when you touch out of the view
        addDummyView()
    }
    
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func getTargetView(object: NSObject) -> UIView? {
        if let barButtonItem = object as? UIBarButtonItem {
            return barButtonItem.value(forKey: "view") as? UIView //get the view from UIBarButtonItem
        } else if let view = object as? UIView {
            return view
        } else {
            return nil
        }
    }
    
    
    private func addText() {
        var xPostion = self.frame.width/1.9 // right
        if textPostion == .bottomLeft {
            xPostion = self.frame.width/4
        }
        
        primaryTextLabel = UILabel(frame: CGRect(x: xPostion, y: self.frame.width/1.6, width: self.frame.width*3, height: 5))
        primaryTextLabel.text = primaryText
        primaryTextLabel.numberOfLines = 3
        primaryTextLabel.textColor = UIColor.white
        primaryTextLabel.font = primaryFont ?? UIFont.boldSystemFont(ofSize: 20)
        primaryTextLabel.sizeToFit()
        self.addSubview(primaryTextLabel)
        
        secondaryTextLabel = UILabel(frame: CGRect(x: xPostion, y: primaryTextLabel.frame.height+primaryTextLabel.frame.origin.y+spaceBetweenLabel, width: self.frame.width*3, height: 5))
        secondaryTextLabel.text = secondaryText
        secondaryTextLabel.numberOfLines = 9
        secondaryTextLabel.textColor = UIColor.white
        secondaryTextLabel.font = secondaryFont ?? UIFont.systemFont(ofSize: 18)
        secondaryTextLabel.sizeToFit()
        self.addSubview(secondaryTextLabel)
        
        // hide labels
        primaryTextLabel.alpha = 0
        secondaryTextLabel.alpha = 0
        
    }
    
    private func showLabels() {
        UIView.animate(withDuration: 0.5) {
            self.primaryTextLabel.alpha = 1
            self.secondaryTextLabel.alpha = 1
        }
    }
    
    // MARK: Draw circles
    
    private func drawColoredCircle() {
        
        coloredCircleLayer.path = shrinkedBlurWhiteCirclePath.cgPath
        coloredCircleLayer.fillRule = .evenOdd
        coloredCircleLayer.fillColor = circleColor.cgColor
        coloredCircleLayer.opacity = 0.9
        
        self.layer.addSublayer(coloredCircleLayer)
        
        playExpandAnimation()
        
    }
    
    
    private func drawBlurWhiteCircle() {
        
        blurWhiteCircleLayer.path = shrinkedBlurWhiteCirclePath.cgPath
        blurWhiteCircleLayer.fillRule = .evenOdd
        blurWhiteCircleLayer.fillColor = UIColor.white.cgColor
        blurWhiteCircleLayer.opacity = 0.0
        
        self.layer.addSublayer(blurWhiteCircleLayer)
        
        addBulrFilterToWhiteCircle()
        playAnimationForWhiteCircle()
    }
    
    private func addBulrFilterToWhiteCircle() {
        let blurFilter = CIFilter(name: "CIGaussianBlur")
        blurFilter?.setDefaults()
        blurFilter?.setValue(0, forKey: "inputRadius")
        if #available(iOS 10.0, *) {
            blurFilter?.name = "blur"
        }
        blurFilter?.setValue(30, forKey: "inputRadius")
        blurWhiteCircleLayer.filters = [blurFilter!]
    }
    
    // MARK: Animations
    
    private func playExpandAnimation() {
        CATransaction.begin()
        CATransaction.setCompletionBlock({
            self.showLabels()
        })
        let animation = CABasicAnimation(keyPath: "path")
        animation.duration = 0.8
        animation.toValue =  coloredCircleLayerPath.cgPath
        animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        // if you remove it the shape will return to the original shape after the animation finished
        animation.fillMode = .both
        animation.isRemovedOnCompletion = false
        
        coloredCircleLayer.add(animation, forKey: nil)
        CATransaction.commit()
    }
    
    
    
    private func playAnimationForWhiteCircle() {
        
        let animation = CABasicAnimation(keyPath: "path")
        animation.duration = 1.55
        animation.beginTime = CACurrentMediaTime() + 0.8
        animation.toValue =  expandedBlurWhiteCirclePath.cgPath
        animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        animation.repeatCount = HUGE
        // if you remove it the shape will return to the original shape after the animation finished
        animation.fillMode = .both
        animation.isRemovedOnCompletion = false
        blurWhiteCircleLayer.add(animation, forKey: nil)
        
        let opacityanimation: CABasicAnimation = CABasicAnimation(keyPath: "opacity");
        opacityanimation.fromValue = 0.7
        opacityanimation.toValue = 0
        opacityanimation.beginTime = CACurrentMediaTime() + 0.8
        opacityanimation.repeatCount = HUGE
        opacityanimation.duration = 1.55
        blurWhiteCircleLayer.add(opacityanimation, forKey: nil)
        
    }
    
    // when touch the icon run the action
    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        
        // if button clicked invoke action
        let isButtonClicked = shrinkedBlurWhiteCirclePath.cgPath.boundingBoxOfPath.contains(touch!.location(in: self))
        if isButtonClicked {
            action()
            dismiss(isButtonClicked:true)
            return
        }
        
        dismiss(isButtonClicked:false)
        
    }
    
    
    // dummy view used to stop user interaction
    private func addDummyView() {
        dummyView = UIView(frame: CGRect(x: 0, y: 0, width: appWindow!.frame.size.width, height: appWindow!.frame.size.height))
        dummyView?.backgroundColor = UIColor.clear
        dummyView?.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismiss))
        dummyView?.addGestureRecognizer(tapGesture)
        appWindow!.addSubview(dummyView!)
        appWindow!.bringSubviewToFront(self)
    }
    
    override public func removeFromSuperview() {
        super.removeFromSuperview()
        dummyView?.removeFromSuperview()
    }
    
    // dismiss the view
    @objc private func dismiss(isButtonClicked:Bool) {
        if !isButtonClicked { dismissed() }
        self.removeFromSuperview()
    }
    
}


// MARK: Size of circles (Paths)

extension MaterialTapTargetPrompt {
    
    private var smallCirclePath: UIBezierPath {
        get {
            let convertedFrame = self.convert(targetView.frame, from: targetView.superview)
            return  UIBezierPath(roundedRect: convertedFrame, cornerRadius: type == .circle ?  targetMidHeight : 0)
        }
    }
    
    private var midCirclePath: UIBezierPath {
        get {
            var convertedFrame = convertedTargetFrame
            convertedFrame.add(number: 100)
            return  UIBezierPath(roundedRect: convertedFrame, cornerRadius: type == .circle ? convertedFrame.height+100 : 0)
        }
    }
    
    private var bigCirclePath: UIBezierPath {
        get {
            let size = self.frame.size.width
            var convertedFrame = convertedTargetFrame
            convertedFrame.add(number:size)
            return  UIBezierPath(roundedRect: convertedFrame, cornerRadius: type == .circle ? convertedFrame.height+size : 0)
        }
    }
    
    private var shrinkedBlurWhiteCirclePath: UIBezierPath {
        get {
            let path = smallCirclePath
            path.append(smallCirclePath)
            path.usesEvenOddFillRule = true
            return path
        }
    }
    
    private var expandedBlurWhiteCirclePath: UIBezierPath {
        let path = midCirclePath
        path.append(smallCirclePath)
        path.usesEvenOddFillRule = true
        return path
    }
    
    
    private var coloredCircleLayerPath: UIBezierPath {
        let path = bigCirclePath
        path.append(smallCirclePath)
        path.usesEvenOddFillRule = true
        return path
    }
}

// MARK: Dimension

extension MaterialTapTargetPrompt {
    private var width: CGFloat {
        return frame.size.width
    }
    
    private var height: CGFloat {
        return frame.size.height
    }
    
    private var midHeight: CGFloat {
        return frame.size.height / 2
    }
    
    private var midWidth: CGFloat {
        return frame.size.width / 2
    }
    
    private var x: CGFloat {
        return frame.origin.x
    }
    
    private var y: CGFloat {
        return frame.origin.y
    }
    
    private var midX: CGFloat {
        return frame.origin.x
    }
    
    private var midY: CGFloat {
        return frame.origin.y
    }
    
    
    
    private var convertedTargetFrame: CGRect {
        return self.convert(targetView.frame, from:targetView.superview)
    }
    
    private  var targetWidth: CGFloat {
        return convertedTargetFrame.size.width
    }
    
    private var targetHeight: CGFloat {
        return convertedTargetFrame.size.height
    }
    
    private var targetMidHeight: CGFloat {
        return convertedTargetFrame.size.height / 2
    }
    
    private var targetMidWidth: CGFloat {
        return convertedTargetFrame.size.width / 2
    }
    
    private var targetX: CGFloat {
        return convertedTargetFrame.origin.x
    }
    
    private var targetY: CGFloat {
        return convertedTargetFrame.origin.y
    }
    
    private var targetMidX: CGFloat {
        return convertedTargetFrame.midX
    }
    
    private var targetMidY: CGFloat {
        return convertedTargetFrame.midY
    }
    
}


extension CGRect {
    fileprivate mutating func add(number: CGFloat) {
        self.size.height += number
        self.size.width += number
        self.origin.x -= (number/2)
        self.origin.y -= (number/2)
    }
}


@objc public enum TextPostion: Int {
    case bottomRight
    case bottomLeft
    case topLeft
    case topRight
    case centerLeft
    case centerRight
    case cenertTop
    case centerBottom
}


@objc public enum Type: Int {
    case circle
    case rectangle
    case square
}
