//
//  MemeTextFieldDelegate.swift
//  Meme Experiments
//
//  Created by Bruno Barbosa on 16/04/17.
//  Copyright © 2017 Bruno Barbosa. All rights reserved.
//

import UIKit

class MemeTextFieldDelegate: NSObject, UITextFieldDelegate {
    
    // MARK: Properties
    
    weak var memeView: MemeView?
    
    let defaultText = ["TOP", "BOTTOM"]
    
    // MARK: Text Field Behaviours
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if let memeView = memeView {
            memeView.disableControls(true)
        }
        
        for value in defaultText {
            if let textFieldText = textField.text {
                if (textFieldText == value) {
                    textField.text = ""
                    break
                }
            }
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let memeView = memeView {
            memeView.disableControls(false)
            
            guard let text = textField.text, !text.isEmpty else {
                if (textField == memeView.topTextField) {
                    textField.text = defaultText[0]
                }
                else if (textField == memeView.bottomTextField) {
                    textField.text = defaultText[1]
                }
                
                return
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
