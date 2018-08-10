//
//  NextViewController.swift
//  MaterialTapTargetPrompt
//
//  Created by abedalkareem omreyh on 1/26/18.
//  Copyright © 2018 abedalkareem omreyh. All rights reserved.
//

import UIKit
import MaterialTapTargetPrompt_iOS

class NextViewController: UIViewController {

    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var centerButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showForBack()
    }
    
    @IBAction func showForBackButton(_ sender: UIButton) {
        showForBack()
    }
    
    @IBAction func showForCenterButton(_ sender: UIButton) {
        let tapTargetPrompt = MaterialTapTargetPrompt(target: centerButton, type: .rectangle)
        tapTargetPrompt.action = {
            print("center clicked")
        }
        tapTargetPrompt.circleColor = #colorLiteral(red: 0.1568627451, green: 0.6588235294, blue: 0.8901960784, alpha: 1)
        tapTargetPrompt.primaryText = "Center Button"
        tapTargetPrompt.secondaryText = "This button show a bad things"
        tapTargetPrompt.textPostion = .centerBottom
    }
    
    func showForBack() {
        let tapTargetPrompt = MaterialTapTargetPrompt(target: backButton)
        tapTargetPrompt.action = {
            print("back clicked")
        }
        tapTargetPrompt.dismissed = {
            print("view dismissed")
        }
        tapTargetPrompt.circleColor = #colorLiteral(red: 0.1568627451, green: 0.6588235294, blue: 0.8901960784, alpha: 1)
        tapTargetPrompt.primaryText = "BACK !"
        tapTargetPrompt.secondaryText = "if you clicked here, you will go back to previous screen"
        tapTargetPrompt.textPostion = .topRight
    }
    
    @IBAction func back(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    

}
