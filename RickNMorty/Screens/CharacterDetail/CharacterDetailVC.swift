//
//  DetailVC.swift
//  RickNMorty
//
//  Created by Fatih Gursoy on 4.07.2022.
//

import UIKit

class CharacterDetailVC: UIViewController {

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
    
    private var viewModel: CharacterDetailViewModel
    
    weak var delegate: CharacterListViewModelDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        viewModel.fetchLastEpisode()
        configureUI()
    }
    
    init?(coder: NSCoder, delegate: CharacterListViewModelDelegate, viewModel: CharacterDetailViewModel) {
        self.viewModel = viewModel
        self.delegate = delegate
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI() {
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
        
        guard let charID = viewModel.charID else {return}
        favButton.isSelected.toggle()
        
        switch viewModel.isSaved {
        case true:
            viewModel.deleteFromFavorites(charID)
        case false:
            viewModel.addToFavorites(charID)
        }
        delegate?.updateUI()
    }
    
}

extension CharacterDetailVC: CharacterDetailViewModelDelegate {
    
    func updateUI() {
        
        DispatchQueue.main.async { [weak self] in
            
            guard let lastEpisode = self?.viewModel.lastSeenEpisodeName,
                  let lastEpisodeDate = self?.viewModel.lastEpisodeAirDate else {return}
            
            self?.lastSeenEpisode.text = lastEpisode + ": " + lastEpisodeDate
        }
    }
}
