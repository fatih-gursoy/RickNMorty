//
//  CharacterListBuilder.swift
//  RickNMorty
//
//  Created by Fatih Gursoy on 26.07.2022.
//

import UIKit

class CharacterListBuilder {
    
    static func build(viewModel: CharacterListViewModel) -> UIViewController {
        
        let characterListVC = UIStoryboard(name: "Main",
                                    bundle: nil).instantiateViewController(identifier: "CharacterListVC", creator: { coder in
            return CharacterListVC(coder: coder, viewModel: viewModel) })
        
        return characterListVC
    }
    
}
