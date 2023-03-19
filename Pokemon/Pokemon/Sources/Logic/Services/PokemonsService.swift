//
//  File.swift
//  Pokemon
//
//  Created by Eduard Ani on 18.03.2023.
//

import Foundation

protocol PokemonsServiceProtocol: Service {
    var pokemons: [Pokemon] { get async throws }
    
    func pokemonDetails(url: URL) async throws -> PokemonDetails
}

final class PokemonsService: PokemonsServiceProtocol {
    let networkClient: NetworkClientProtocol
    var path: String { APIConstants.Path.pokemon }
    
    var pokemons: [Pokemon] {
        get async throws {
            let request = URLRequest(url: url)
            
            struct Response: Decodable {
                let results: [Pokemon]
            }
            
            let response: Response = try await networkClient.load(request)
            return response.results
        }
    }
    
    init(networkClient: NetworkClientProtocol) {
        self.networkClient = networkClient
    }
    
    func pokemonDetails(url: URL) async throws -> PokemonDetails {
        let request = URLRequest(url: url)
        return try await networkClient.load(request)
    }
}
