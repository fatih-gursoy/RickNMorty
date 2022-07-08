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
    
    init(service: NetworkManagerProtocol = NetworkManager.shared) {
        self.service = service
    }
    
    var characters: [Character] = []
    var isPageLoading: Bool = false
    var isLastPage: Bool = false
    
    var currentPage: Int = 1
    var filterName = ""
    var filterStatus = ""
    
    var isFiltered: Bool = false {
        didSet {
            currentPage = 1
            isLastPage = false
            isPageLoading = false
        }
    }
    
}

extension CharacterListViewModel {
    
    func fetchCharacters() {
        
        guard !isPageLoading && !isLastPage else {return}
        isPageLoading = true
        
        service.fetch(endPoint: API.character(
            [.page(currentPage),
             .name(filterName),
             .status(filterStatus)])) { [weak self] (response: Response) in
                 
                 guard let self = self,
                       let characters = response.results else { return }
                 
                 if self.currentPage == 1 { self.characters.removeAll(keepingCapacity: false) }
                 self.characters.append(contentsOf: characters)
                 self.delegate?.updateUI()
                 
                 self.isPageLoading = false
                 self.isFiltered = false
                 
                 guard let pageCount = response.info?.pages else { return }
                 guard self.currentPage <= pageCount else {
                     self.isLastPage = true
                     return }
                 self.currentPage += 1
             }
    }
    
}
