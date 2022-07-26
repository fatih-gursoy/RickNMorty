//
//  EndPoint.swift
//  RickNMorty
//
//  Created by Fatih Gursoy on 4.07.2022.
//

import Foundation

protocol EndPoint {
    var baseURL: String { get }
    var path: String { get }
    var queryItems: [URLQueryItem]? { get }
    var url: URL { get }
}

enum API: EndPoint {
    
    case character([Params])
    case episode(String)
    
    var baseURL: String {
        return "https://rickandmortyapi.com"
    }
    
    var path: String {
        switch self {
        case .character:
            return "/api/character"
        case .episode(let episodeNum):
            return "/api/episode/\(episodeNum)"
        }
    }
    
    var url : URL {
        var components = URLComponents(string: baseURL)!
        components.path = path
        components.queryItems = queryItems
        guard let url = components.url else { fatalError() }
        return url
    }
    
    var queryItems: [URLQueryItem]? {
        switch self {
        case .character(let queryList):
            return queryList.map { $0.queryItem }
        case .episode(_):
            return nil
        }
    }
}

enum Params {
    
    case page(Int)
    case name(String)
    case status(String)
    
    var queryItem: URLQueryItem {
        
        switch self {
        case .page(let pageNumber):
            return URLQueryItem(name: "page", value: "\(pageNumber)")
        case .name(let name):
            return URLQueryItem(name: "name", value: name)
        case .status(let status):
            return URLQueryItem(name: "status", value: status)
        }
    }
}


