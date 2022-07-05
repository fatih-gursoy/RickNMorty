//
//  NetworkManager.swift
//  RickNMorty
//
//  Created by Fatih Gursoy on 4.07.2022.
//

import Foundation
import Alamofire

protocol NetworkManagerProtocol: AnyObject {
    
    func fetch<T:Decodable>(endPoint: EndPoint, completion: @escaping((T) -> Void))
    
}


class NetworkManager: NetworkManagerProtocol {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetch<T>(endPoint: EndPoint, completion: @escaping ((T) -> Void)) where T : Decodable {
        
        
        
        
        
    }
    
}
