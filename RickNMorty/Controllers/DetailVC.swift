//
//  DetailVC.swift
//  RickNMorty
//
//  Created by Fatih Gursoy on 4.07.2022.
//

import UIKit

class DetailVC: UIViewController {

    @IBOutlet weak var image: CustomImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var species: UILabel!
    @IBOutlet weak var numberofEpisodes: UILabel!
    @IBOutlet weak var gender: UILabel!
    @IBOutlet weak var originName: UILabel!
    @IBOutlet weak var locationName: UILabel!
    @IBOutlet weak var lastSeenEpisode: UILabel!
    
    var viewModel : CharacterViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        
    }
    
    func configureUI() {
        
        guard let viewModel = viewModel else {return}

        name.text = viewModel.name
        image.setImage(url: viewModel.image)
        status.text = viewModel.status
        species.text = viewModel.species
        numberofEpisodes.text = viewModel.numberofEpisodes
        gender.text = viewModel.gender
        originName.text = viewModel.originName
        locationName.text = viewModel.locationName
//        lastSeenEpisode.text = viewModel.lastSeenEpisodeName! + ":" + viewModel.lastEpisodeAirDate!
        
    }


}
