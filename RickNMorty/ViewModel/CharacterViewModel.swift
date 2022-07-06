//
//  CharacterViewModel.swift
//  RickNMorty
//
//  Created by Fatih Gursoy on 5.07.2022.
//

import Foundation

protocol CharacterViewModelDelegate: AnyObject {
    func updateUI()
}

class CharacterViewModel {
    
    private let character: Character
    weak var delegate: CharacterViewModelDelegate?
    
    private var coreDataManager = CoreDataManager.shared
    
    init(character: Character) {
        self.character = character
        fetchLastEpisode()
    }
    
    var name: String? {
        return character.name
    }
    
    var charID: String? {
        guard let id = character.id else {return nil}
        return String(id)
    }

    var image: String? {
        return character.image
    }
    
    var status: String? {
        return character.status?.rawValue
    }
    
    var species: String? {
        return character.species?.rawValue
    }
    
    var gender: String? {
        return character.gender?.rawValue
    }
    
    var numberofEpisodes: String {
        
        guard let count = character.episode?.count else {return "0"}
        return String(describing: count)
    }
    
    var originName: String? {
        return character.origin?.name
    }
    
    var locationName: String? {
        return character.location?.name
    }
        
    var lastSeenEpisodeName: String?
    var lastEpisodeAirDate: String?
    
    var isSaved: Bool {
        let isSaved = coreDataManager.favChars.filter { $0.id == self.charID }.first
        return isSaved != nil
    }
    
//MARK: Functions
    
    private func fetchLastEpisode() {
    
        guard let urlString = character.episode?.last,
              let url = URL(string: urlString) else { return }
        
        NetworkManager.shared.fetchByURL(url: url) { [weak self] (result: Episode) in
            
            self?.lastSeenEpisodeName = result.name
            self?.lastEpisodeAirDate = result.airDate
            self?.delegate?.updateUI()
            
        }
    }
    
    func addToFavorites(_ id: String) {
        
        coreDataManager.addToFavorites(id)
        
    }

    func deleteFromFavorites(_ id: String){
        
        coreDataManager.deleteRecipe(id)
        
    }
    
    
}
