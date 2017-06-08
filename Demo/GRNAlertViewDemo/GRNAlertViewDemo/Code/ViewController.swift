//
//  ViewController.swift
//  GRNAlertView
//
//  Created by Wojciech on 2017-06-05.
//  Copyright © 2017 Guarana. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var subtitleTextField: UITextField!
    @IBOutlet weak var messageTextField: UITextField!
    @IBOutlet weak var leftButtonTitleTextField: UITextField!
    @IBOutlet weak var rightButtonTitleTextField: UITextField!
    
    @IBOutlet weak var imageSwitch: UISwitch!
    @IBOutlet weak var customFontSwitch: UISwitch!
    @IBOutlet weak var backgroundTypeControl: UISegmentedControl!
    @IBOutlet weak var textColorControl: UISegmentedControl!
    @IBOutlet weak var backgroundColorControl: UISegmentedControl!
    @IBOutlet weak var cornerRadiusSlider: UISlider!
    
    @IBAction func showAction(_ sender: UIButton) {
        var content = GRNAlertContent()
        content.title = titleTextField.text
        content.subtitle = subtitleTextField.text
        content.message = messageTextField.text
        content.image = imageSwitch.isOn ? #imageLiteral(resourceName: "alert_icn") : nil
        if (leftButtonTitleTextField.text?.characters.count)! > 0 {
            content.firstButtonTitle = leftButtonTitleTextField.text
        }
        if (rightButtonTitleTextField.text?.characters.count)! > 0 {
            content.secondButtonTitle = rightButtonTitleTextField.text
        }
        
        var layout = GRNAlertLayout()
        if backgroundTypeControl.selectedSegmentIndex == 0 {
            layout.backgroundType = .clear
        } else if backgroundTypeControl.selectedSegmentIndex == 1 {
            layout.backgroundType = .transparentDark
        } else {
            layout.backgroundType = .transparentLight
        }
        
        if textColorControl.selectedSegmentIndex == 0 {
            layout.textColor = .black
        } else if textColorControl.selectedSegmentIndex == 1 {
            layout.textColor = UIColor.red
        } else {
            layout.textColor = UIColor.green
        }
        
        if backgroundColorControl.selectedSegmentIndex == 0 {
            layout.backgroundColor = .white
        } else if backgroundColorControl.selectedSegmentIndex == 1 {
            layout.backgroundColor = UIColor.lightGray
        } else {
            layout.backgroundColor = UIColor.blue
        }
        
        layout.cornerRadius = CGFloat(cornerRadiusSlider.value)
        if customFontSwitch.isOn {
            let font = titleTextField.font!
            layout.titleFont = font.withSize(17.0)
            layout.subtitleFont = font.withSize(14.0)
            layout.messageFont = font.withSize(16.0)
            layout.buttonsFont = font.withSize(16.0)
        }
        
        let alert = GRNAlertViewController(content: content, layout: layout)
        alert.show(on: self)
    }
    
    @IBAction func showDefaultAction(_ sender: UIButton) {
        let alert = GRNAlertViewController(title: "Default alert", message: "Default message")
        alert.show(on: self)
    }

}

