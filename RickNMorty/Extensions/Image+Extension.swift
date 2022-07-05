//
//  Image+Extension.swift
//  RickNMorty
//
//  Created by Fatih Gursoy on 5.07.2022.
//

import Foundation
import Kingfisher

extension UIImageView {
    
    func setImage(url: String?) {
        
        guard let url = url else {return}
        self.kf.setImage(with: URL(string: url))
        
    }
    
}
