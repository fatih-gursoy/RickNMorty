//
//  CharacterViewModel.swift
//  RickNMorty
//
//  Created by Fatih Gursoy on 5.07.2022.
//

import Foundation

protocol CharacterDetailViewModelDelegate: AnyObject {
    func updateUI()
}

class CharacterDetailViewModel {
    
    private let character: Character
    private var coreDataManager = CoreDataManager.shared
    
    weak var delegate: CharacterDetailViewModelDelegate?
    
    init(character: Character) {
        self.character = character
    }
    
//MARK: - Properties
    
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
        return character.species
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
    
// MARK: - Functions
    
    func fetchLastEpisode() {
    
        guard let episodeNum = character.episode?.last?.split(separator: "/").last else {return}
        let num = String(episodeNum)

        NetworkManager.shared.fetch(endPoint: API.episode(num)) { [weak self] (result: Episode) in
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
