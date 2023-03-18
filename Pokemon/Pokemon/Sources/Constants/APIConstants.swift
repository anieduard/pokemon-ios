//
//  APIConstants.swift
//  Pokemon
//
//  Created by Eduard Ani on 18.03.2023.
//

import Foundation

enum APIConstants {
    enum URL {
        static let scheme: String = "https"
        static let host: String   = "pokeapi.co"
    }
    
    enum Path {
        static func path(_ path: String) -> String { "/api/v2" + path }
        
        static let pokemon = path("/pokemon")
    }
}
