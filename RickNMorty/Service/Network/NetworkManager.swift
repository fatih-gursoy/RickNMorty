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
    func fetchByURL<T:Decodable>(url: URL, completion: @escaping (T) -> Void)

}

class NetworkManager: NetworkManagerProtocol {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetch<T:Decodable>(endPoint: EndPoint, completion: @escaping (T) -> Void) {
        
        let url = endPoint.url
        let request = AF.request(url)
        
        request.validate().responseDecodable(of: T.self) { response in
            
            guard let result = response.value else {return}
            completion(result)
        }
    }
    
    func fetchByURL<T:Decodable>(url: URL, completion: @escaping (T) -> Void) {
        
        let request = AF.request(url)
        
        request.validate().responseDecodable(of: T.self) { response in
            
            guard let result = response.value else {return}
            completion(result)
            
        }
    }
    
}
