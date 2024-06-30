//
//  CustomTextFields.swift
//  WeatherApp
//
//  Created by durodola on 29/06/2024.
//

import UIKit

class ThemeTextField: UITextField {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        if #available(iOS 11.0, *) {
                   self.clipsToBounds = true
                   self.layer.cornerRadius = 6
               } else {
                   // Fallback on earlier versions
               }
               
        self.layer.borderWidth = 0.8
        self.layer.borderColor = UIColor(named: "AppColor")?.cgColor
    }
    
    
    let padding = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 5)
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
}
