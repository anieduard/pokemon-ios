//
//  File.swift
//  Pokemon
//
//  Created by Eduard Ani on 18.03.2023.
//

import Foundation

protocol PokemonsServiceProtocol: Service {
    func pokemons(url: URL?) async throws -> ([Pokemon], URL)
    func pokemonDetails(url: URL) async throws -> PokemonDetails
}

final class PokemonsService: PokemonsServiceProtocol {
    let networkClient: NetworkClientProtocol
    var path: String { APIConstants.Path.pokemon }
    
    init(networkClient: NetworkClientProtocol) {
        self.networkClient = networkClient
    }
    
    func pokemons(url: URL?) async throws -> ([Pokemon], URL) {
        let request = URLRequest(url: url ?? self.url)
        
        struct Response: Decodable {
            let results: [Pokemon]
            let next: URL
        }
        
        let response: Response = try await networkClient.load(request)
        return (response.results, response.next)
    }
    
    func pokemonDetails(url: URL) async throws -> PokemonDetails {
        let request = URLRequest(url: url)
        return try await networkClient.load(request)
    }
}
