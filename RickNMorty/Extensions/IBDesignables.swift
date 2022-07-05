//
//  CustomView.swift
//  RickNMorty
//
//  Created by Fatih Gursoy on 6.07.2022.
//

import Foundation
import UIKit

@IBDesignable
class CustomView: UIView {
    
    @IBInspectable var cornerRadius: CGFloat {
        get { return self.layer.cornerRadius}
        set { self.layer.cornerRadius = newValue}
    }
    
    
}

@IBDesignable
class CustomImageView: UIImageView {
    
    @IBInspectable var cornerRadius: CGFloat {
        get { return self.layer.cornerRadius}
        set { self.layer.cornerRadius = newValue}
    }
    
    
}
