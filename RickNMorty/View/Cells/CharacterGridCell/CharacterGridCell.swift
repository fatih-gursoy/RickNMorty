//
//  CharacterCell.swift
//  RickNMorty
//
//  Created by Fatih Gursoy on 4.07.2022.
//

import UIKit

class CharacterGridCell: UICollectionViewCell {

    static let identifier = "CharacterGridCell"
    
    @IBOutlet weak private var name: UILabel!
    @IBOutlet weak private var image: UIImageView!
    @IBOutlet weak private var species: UILabel!
    @IBOutlet weak private var status: UILabel!
    @IBOutlet weak private var favButton: UIButton!
    
    func configureCell(viewModel: CharacterViewModel) {
        
        name.text = viewModel.name
        status.text = viewModel.status
        species.text = viewModel.species
        image.setImage(url: viewModel.image)
        
        viewModel.isSaved
        ? favButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        : favButton.setImage(UIImage(systemName: "heart"), for: .normal)
        
    }
    
    
}