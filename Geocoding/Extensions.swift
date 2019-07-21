//
//  extensions.swift
//  Geocoding
//
//  Created by George Shafik on 13/7/19.
//  Copyright © 2019 George Shafik. All rights reserved.
//

import UIKit

extension UIViewController: UITextFieldDelegate {
  
  open func hideKeybord() {
    for textField in self.view.subviews where textField is UITextField {
      textField.resignFirstResponder()
    }
  }
  
  // UITestFieldDelegate Methods
  open func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    hideKeybord()
    return true
  }
  
}
