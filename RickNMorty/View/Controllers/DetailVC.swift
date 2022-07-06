//
//  DetailVC.swift
//  RickNMorty
//
//  Created by Fatih Gursoy on 4.07.2022.
//

import UIKit

class DetailVC: UIViewController {

    @IBOutlet private weak var image: CustomImageView!
    @IBOutlet private weak var name: UILabel!
    @IBOutlet private weak var status: UILabel!
    @IBOutlet private weak var species: UILabel!
    @IBOutlet private weak var numberofEpisodes: UILabel!
    @IBOutlet private weak var gender: UILabel!
    @IBOutlet private weak var originName: UILabel!
    @IBOutlet private weak var locationName: UILabel!
    @IBOutlet private weak var lastSeenEpisode: UILabel!
    @IBOutlet private weak var favButton: CustomButton!
    
    var notificationCenter = NotificationCenter.default
    var viewModel : CharacterViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        
    }
    
    func configureUI() {
        
        guard let viewModel = viewModel else {return}
        
        viewModel.delegate = self

        name.text = viewModel.name
        image.setImage(url: viewModel.image)
        status.text = viewModel.status
        species.text = viewModel.species
        numberofEpisodes.text = viewModel.numberofEpisodes
        gender.text = viewModel.gender
        originName.text = viewModel.originName
        locationName.text = viewModel.locationName
        favButton.isSelected = viewModel.isSaved

    }

    @IBAction func favButtonTapped(_ sender: Any) {
        
        guard let viewModel = viewModel,
              let charID = viewModel.charID else {return}
        
        favButton.isSelected.toggle()
        
        switch viewModel.isSaved {
            
        case true:
            viewModel.deleteFromFavorites(charID)
            
        case false:
            viewModel.addToFavorites(charID)
        }
        
        notificationCenter.post(name: NSNotification.Name(rawValue: "RefreshFavorites"), object: nil)
    }
    
}

extension DetailVC: CharacterViewModelDelegate {
    
    func updateUI() {
        
        DispatchQueue.main.async { [weak self] in
            
            guard let lastEpisode = self?.viewModel?.lastSeenEpisodeName,
                  let lastEpisodeDate = self?.viewModel?.lastEpisodeAirDate else {return}
            
            self?.lastSeenEpisode.text = lastEpisode + ": " + lastEpisodeDate
            
        }
        
    }
}
