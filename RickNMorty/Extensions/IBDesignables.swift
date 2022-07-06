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

@IBDesignable
class CustomButton: UIButton {
    
    @IBInspectable var shadowColor: UIColor? {
        get {
            if let color = layer.shadowColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                self.layer.shadowColor = color.cgColor
            }
        }
    }
    
    @IBInspectable var shadowOffset: CGSize {
        get {
            return self.layer.shadowOffset
        }
        set {
            self.layer.shadowOffset = newValue
        }
    }
    
    @IBInspectable var shadowRadius: CGFloat {
        get {
            return self.layer.shadowRadius
        } set {
            self.layer.shadowRadius = newValue
        }
    }
    
    @IBInspectable var shadowOpacity: Float {
        get {
            return self.layer.shadowOpacity
        } set {
            self.layer.shadowOpacity = newValue
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat {
        get { return self.layer.cornerRadius }
        set { self.layer.cornerRadius = newValue}
    }
    
}
