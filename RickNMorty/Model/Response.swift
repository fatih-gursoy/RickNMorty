//
//  Response.swift
//  RickNMorty
//
//  Created by Fatih Gursoy on 4.07.2022.
//

import Foundation

// MARK: - Response
struct Response: Codable {
    
    let info: Info?
    let Characters: [Character]?

}

// MARK: - Info
struct Info: Codable {
    
    let count, pages: Int?
    let next, prev: String?
    
}
