//
//  PokemonDetails.swift
//  Pokemon
//
//  Created by Eduard Ani on 19.03.2023.
//

import Foundation

struct PokemonDetails: Decodable {
    let name: String
    let sprites: Sprites
    let types: [`Type`]
}

extension PokemonDetails {
    struct Sprites: Decodable {
        private enum CodingKeys: String, CodingKey {
            case frontDefault = "front_default"
        }
        
        let frontDefault: URL
        
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            
            frontDefault = try container.decode(URL.self, forKey: .frontDefault)
        }
    }
}

extension PokemonDetails {
    struct `Type`: Decodable {
        struct `Type`: Decodable {
            let name: String
        }
        
        let type: `Type`
    }
}
