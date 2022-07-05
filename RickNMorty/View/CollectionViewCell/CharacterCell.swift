//
//  CharacterCell.swift
//  RickNMorty
//
//  Created by Fatih Gursoy on 4.07.2022.
//

import UIKit

class CharacterCell: UICollectionViewCell {

    static let identifier = "CharacterCell"
    
    @IBOutlet weak private var name: UILabel!
    @IBOutlet weak private var image: UIImageView!
    @IBOutlet weak private var species: UILabel!
    @IBOutlet weak private var status: UILabel!
    
    func configureCell(viewModel: CharacterViewModel) {
        
        name.text = viewModel.name
        status.text = viewModel.status
        species.text = viewModel.species
        image.setImage(url: viewModel.image)
        
    }
    
    
}
