//
//  CharacterDetailBuilder.swift
//  RickNMorty
//
//  Created by Fatih Gursoy on 18.07.2022.
//

import UIKit

class CharacterDetailBuilder {
    
    static func build(viewModel: CharacterDetailViewModel, delegate: CharacterListViewModelDelegate) -> UIViewController {
        
        let detailVC = UIStoryboard(name: "Main",
                                    bundle: nil).instantiateViewController(identifier: "DetailVC", creator: { coder in
            return CharacterDetailVC(coder: coder, delegate: delegate ,viewModel: viewModel) })
        
        return detailVC
    }
    
}
