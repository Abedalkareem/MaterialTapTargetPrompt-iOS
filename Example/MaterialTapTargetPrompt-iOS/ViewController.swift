//
//  ViewController.swift
//  MaterialTapTargetPrompt-iOS
//
//  Created by Abedalkareem on 08/10/2018.
//  Copyright (c) 2018 Abedalkareem. All rights reserved.
//

import UIKit
import MaterialTapTargetPrompt

class ViewController: UIViewController {
  @IBOutlet private weak var rightBarButton: UIBarButtonItem!
  @IBOutlet private weak var leftBarButton: UIBarButtonItem!
  override func viewDidLoad() {
    super.viewDidLoad()

  }

  @IBAction func showLeftShowcase(_ sender: UIButton) {
    let tapTargetPrompt = MaterialTapTargetPrompt(target: leftBarButton)
    tapTargetPrompt.action = {
      print("left clicked")
    }
    tapTargetPrompt.dismissed = {
      print("view dismissed")
    }
    tapTargetPrompt.circleColor = #colorLiteral(red: 0.1568627451, green: 0.6588235294, blue: 0.8901960784, alpha: 1)
    tapTargetPrompt.primaryText = "Add Home"
    tapTargetPrompt.secondaryText = "Here you can add home"
    tapTargetPrompt.textPostion = .bottomRight
  }

  @IBAction func showRightShowcase(_ sender: UIButton) {
    let tapTargetPrompt = MaterialTapTargetPrompt(target: rightBarButton)
    tapTargetPrompt.action = {
      print("right clicked")
    }
    tapTargetPrompt.circleColor = #colorLiteral(red: 0.1568627451, green: 0.6588235294, blue: 0.8901960784, alpha: 1)
    tapTargetPrompt.primaryText = "Slide Menu"
    tapTargetPrompt.secondaryText = "This menu show a good things"
    tapTargetPrompt.textPostion = .bottomLeft
  }

}
