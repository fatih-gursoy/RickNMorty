//
//  CharacterListViewModel.swift
//  RickNMorty
//
//  Created by Fatih Gursoy on 5.07.2022.
//

import Foundation

protocol CharacterListDelegate: AnyObject {
    
    func updateUI()
}

class CharacterListViewModel {
    
    private let service: NetworkManagerProtocol
    
    weak var delegate: CharacterListDelegate?
    
    init(service: NetworkManager = NetworkManager.shared) {
        self.service = service
    }
    
    var characters: [Character] = []
    
}

extension CharacterListViewModel {
    
    func fetchCharacters(pageNum: Int) {
        
        service.fetch(endPoint: API.character([.page(pageNum)])) { [weak self] (response: Response) in
            
            guard let characters = response.results else { return }
            self?.characters.append(contentsOf: characters)
            self?.delegate?.updateUI()
        }
    }

}
