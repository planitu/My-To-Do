//
//  NewTaskVC + Delegates.swift
//  My ToDo
//
//  Created by Максим on 21.04.2022.
//

import UIKit

extension NewTaskVC: UITextFieldDelegate, UITextViewDelegate {

// MARK: TextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {

        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {

        textField.resignFirstResponder()
    }
    
    
// MARK: TextViewDelegate
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
               textView.text = "Введите описание(необязательно)"
           }
        textView.resignFirstResponder()
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "Введите описание(необязательно)" {
            textView.text = nil
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
}

