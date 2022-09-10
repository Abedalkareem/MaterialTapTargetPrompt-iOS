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

  public typealias VoidCallback = () -> Void

  // MARK: - Public properties

  /// The primary label font.
  @objc public var primaryFont: UIFont?

  /// The secondary label font.
  @objc public var secondaryFont: UIFont?

  /// The action which will run when the target clicked.
  @objc public var action: VoidCallback?

  /// The action will which  run when the user click out of the target.
  @objc public var dismissed: VoidCallback?

  /// The primary text. That text which will be above the secondary text.
  @objc public var primaryText: String = "Primary text Here !" {
    willSet {
      primaryTextLabel.text = newValue
      primaryTextLabel.sizeToFit()
    }
  }

  /// The secondary text. That text which will be below the primary text.
  @objc public var secondaryText: String = "Secondary text Here !" {
    willSet {
      secondaryTextLabel.text = newValue
      secondaryTextLabel.sizeToFit()
    }
  }

  /// The circel color. `UIColor.blue` by default.
  @objc public var circleColor: UIColor = .blue {
    willSet {
      coloredCircleLayer.fillColor = newValue.cgColor
    }
  }

  /// The primary text color. `UIColor.white` by default.
  @objc public var primaryTextColor: UIColor = .white {
    willSet {
      primaryTextLabel.textColor = newValue
    }
  }

  /// The secondary text color. `UIColor.white` by default.
  @objc public var secondaryTextColor: UIColor = .white {
    willSet {
      secondaryTextLabel.textColor = newValue
    }
  }

  /// The text postion around the view. `.bottomRight` by default
  @objc public var textPostion: TextPostion = .bottomRight {
    willSet {
      var xPostion: CGFloat = 0.0
      var yPostion: CGFloat = 0.0

      let width = frame.width
      switch newValue {
      case .bottomRight:
        xPostion = width / 1.9
        yPostion = width / 1.6
      case .bottomLeft:
        xPostion = width / 4
        yPostion = width / 1.6
      case .topRight:
        xPostion = width / 1.9
        yPostion = width / 4
      case .topLeft:
        xPostion = width / 4
        yPostion = width / 4
      case .centerRight:
        xPostion = width / 1.6
        yPostion = width / 2.23
      case .centerLeft:
        xPostion = width / 6
        yPostion = width / 2.23
      case .centerTop:
        xPostion = width / 2.23
        yPostion = width / 4
      case .centerBottom:
        xPostion = width / 2.23
        yPostion = width / 1.6
      }

      // width and height are 0 because sizeToFit are used to resize the labels after they have text.
      primaryTextLabel.frame = CGRect(x: xPostion,
                                      y: yPostion,
                                      width: 0,
                                      height: 0)
      secondaryTextLabel.frame = CGRect(x: xPostion,
                                        y: primaryTextLabel.frame.origin.y + primaryTextLabel.frame.height + spaceBetweenLabel,
                                        width: 0,
                                        height: 0)
    }
  }

  // MARK: - Private Properties

  private var targetView: UIView!
  private let coloredCircleLayer = CAShapeLayer()
  private let blurWhiteCircleLayer = CAShapeLayer()

  private var type: ShapeType!
  private var spaceBetweenLabel: CGFloat = 10.0

  private var primaryTextLabel: UILabel!
  private var secondaryTextLabel: UILabel!
  private var dummyView: UIView?
  private static var appWindow: UIWindow {
    return (UIApplication.shared.connectedScenes
      .compactMap({ $0 as? UIWindowScene })
      .first(where: { $0.activationState == .foregroundActive })?
      .windows
      .first(where: { $0.isKeyWindow })) ?? UIWindow()
  }

  // MARK: - init

  ///
  /// Creates an instance with the target view and the type of shape.
  ///
  /// - parameter target: The view that you want to show the prompt around. The target should be a `View` or a `UIBarButtonItem`.
  /// - parameter type: Type of shape of the view, `ShapeType.circle` by default.
  ///
  /// - returns: A new MaterialTapTargetPrompt instance.
  @objc
  public init(target targetView: NSObject, type: ShapeType = .circle) {
    let sizeOfView = Self.appWindow.frame.width * 2 // set size of view
    super.init(frame: CGRect(x: 0, y: 0, width: sizeOfView, height: sizeOfView))
    self.type = type

    self.targetView = getTargetViewFrom(object: targetView) // get the view from the sended target
    backgroundColor = UIColor.clear // make background of view clear

    let convertedFrame = self.targetView.convert(self.targetView.bounds, to: Self.appWindow)
    self.center = CGPoint(x: convertedFrame.origin.x + convertedFrame.width / 2,
                          y: convertedFrame.origin.y + convertedFrame.height / 2) // center view

    Self.appWindow.addSubview(self) // add to window

    drawColoredCircle()
    drawBlurWhiteCircle()
    addText()

    // dummy view used to hide the MaterialTapTargetPrompt view when you touch out of the view
    addDummyView()
  }

  required public init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func getTargetViewFrom(object: NSObject) -> UIView {
    if let barButtonItem = object as? UIBarButtonItem, let view = barButtonItem.value(forKey: "view") as? UIView {
      return view
    } else if let view = object as? UIView {
      return view
    } else {
      fatalError("Can't get a view from the object. The target should be a view or a UIBarButtonItem")
    }
  }

  private func addText() {

    primaryTextLabel = UILabel()
    primaryTextLabel.text = primaryText
    primaryTextLabel.numberOfLines = 3
    primaryTextLabel.textColor = primaryTextColor
    primaryTextLabel.font = primaryFont ?? UIFont.boldSystemFont(ofSize: 20)
    primaryTextLabel.sizeToFit()
    addSubview(primaryTextLabel)

    secondaryTextLabel = UILabel()
    secondaryTextLabel.text = secondaryText
    secondaryTextLabel.numberOfLines = 9
    secondaryTextLabel.textColor = secondaryTextColor
    secondaryTextLabel.font = secondaryFont ?? UIFont.systemFont(ofSize: 18)
    secondaryTextLabel.sizeToFit()
    addSubview(secondaryTextLabel)

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

  // MARK: - Draw circles

  private func drawColoredCircle() {

    coloredCircleLayer.path = shrinkedBlurWhiteCirclePath.cgPath
    coloredCircleLayer.fillRule = .evenOdd
    coloredCircleLayer.fillColor = circleColor.cgColor
    coloredCircleLayer.opacity = 0.9

    layer.addSublayer(coloredCircleLayer)

    playExpandAnimation()

  }

  private func drawBlurWhiteCircle() {

    blurWhiteCircleLayer.path = shrinkedBlurWhiteCirclePath.cgPath
    blurWhiteCircleLayer.fillRule = .evenOdd
    blurWhiteCircleLayer.fillColor = UIColor.white.cgColor
    blurWhiteCircleLayer.opacity = 0.0

    layer.addSublayer(blurWhiteCircleLayer)

    addBulrFilterToWhiteCircle()
    playAnimationForWhiteCircle()
  }

  private func addBulrFilterToWhiteCircle() {
    let blurFilter = CIFilter(name: "CIGaussianBlur")
    blurFilter?.setDefaults()
    blurFilter?.setValue(0, forKey: "inputRadius")
    blurFilter?.name = "blur"
    blurFilter?.setValue(30, forKey: "inputRadius")
    blurWhiteCircleLayer.filters = [blurFilter!]
  }

  // MARK: - Animations

  private func playExpandAnimation() {
    CATransaction.begin()
    CATransaction.setCompletionBlock({
      self.showLabels()
    })
    let animation = CABasicAnimation(keyPath: "path")
    animation.duration = 0.8
    animation.toValue = coloredCircleLayerPath.cgPath
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
    animation.toValue = expandedBlurWhiteCirclePath.cgPath
    animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
    animation.repeatCount = HUGE
    // if you remove it the shape will return to the original shape after the animation finished
    animation.fillMode = .both
    animation.isRemovedOnCompletion = false
    blurWhiteCircleLayer.add(animation, forKey: nil)

    let opacityanimation: CABasicAnimation = CABasicAnimation(keyPath: "opacity")
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
      action?()
      dismiss(isButtonClicked: true)
      return
    }

    dismiss(isButtonClicked: false)
  }

  // dummy view used to stop user interaction
  private func addDummyView() {
    dummyView = UIView(frame: CGRect(x: 0,
                                     y: 0,
                                     width: Self.appWindow.frame.size.width,
                                     height: Self.appWindow.frame.size.height))
    dummyView?.backgroundColor = UIColor.clear
    dummyView?.isUserInteractionEnabled = true
    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismiss))
    dummyView?.addGestureRecognizer(tapGesture)
    Self.appWindow.addSubview(dummyView!)
    Self.appWindow.bringSubviewToFront(self)
  }

  override public func removeFromSuperview() {
    super.removeFromSuperview()
    dummyView?.removeFromSuperview()
  }

  // dismiss the view
  @objc
  private func dismiss(isButtonClicked: Bool) {
    if !isButtonClicked { dismissed?() }
    removeFromSuperview()
  }

}

// MARK: - Size of circles (Paths)

extension MaterialTapTargetPrompt {

  private var smallCirclePath: UIBezierPath {
      let convertedFrame = convert(targetView.frame, from: targetView.superview)
      return  UIBezierPath(roundedRect: convertedFrame, cornerRadius: type == .circle ?  targetMidHeight : 0)
  }

  private var midCirclePath: UIBezierPath {
      var convertedFrame = convertedTargetFrame
      convertedFrame.add(number: 100)
      return  UIBezierPath(roundedRect: convertedFrame, cornerRadius: type == .circle ? convertedFrame.height + 100 : 0)
  }

  private var bigCirclePath: UIBezierPath {
      let size = frame.size.width
      var convertedFrame = convertedTargetFrame
      convertedFrame.add(number: size)
      return  UIBezierPath(roundedRect: convertedFrame, cornerRadius: type == .circle ? convertedFrame.height + size : 0)
  }

  private var shrinkedBlurWhiteCirclePath: UIBezierPath {
      let path = smallCirclePath
      path.append(smallCirclePath)
      path.usesEvenOddFillRule = true
      return path
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

// MARK: - Dimension

extension MaterialTapTargetPrompt {

  private var convertedTargetFrame: CGRect {
    return convert(targetView.frame, from: targetView.superview)
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

// MARK: -

@objc
public enum TextPostion: Int {
  case bottomRight
  case bottomLeft
  case topLeft
  case topRight
  case centerLeft
  case centerRight
  case centerTop
  case centerBottom
}

// MARK: -

@objc
public enum ShapeType: Int {
  case circle
  case rectangle
  case square
}
