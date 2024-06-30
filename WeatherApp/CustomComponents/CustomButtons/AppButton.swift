//
//  CustomButtons.swift
//  WeatherApp
//
//  Created by durodola on 29/06/2024.
//

import UIKit

class DefaultCustomButton: UIButton {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        if #available(iOS 11.0, *) {
            self.clipsToBounds = true
            self.layer.cornerRadius = 10
        } else {
            // Fallback on earlier versions
        }
        self.backgroundColor = UIColor(named: "AppColor")
        self.setTitleColor(UIColor.white, for: UIControl.State())
    }
}
