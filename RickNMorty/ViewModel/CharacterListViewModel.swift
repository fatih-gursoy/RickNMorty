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
    
    func filterByName(pageNum: Int, name: String) {
        
        service.fetch(endPoint: API.character([.page(pageNum), .name(name)])) { [weak self] (response: Response) in
            
            guard let characters = response.results else { return }
            self?.characters.append(contentsOf: characters)
            self?.delegate?.updateUI()
        }
    }
    
    func filterByStatus(pageNum: Int, status: String) {
        
        service.fetch(endPoint: API.character([.page(pageNum), .status(status)])) { [weak self] (response: Response) in
            
            guard let characters = response.results else { return }
            self?.characters.removeAll(keepingCapacity: false)
            self?.characters = characters
            self?.delegate?.updateUI()
        }
    }


}
