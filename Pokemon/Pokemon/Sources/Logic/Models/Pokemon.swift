//
//  Pokemon.swift
//  Pokemon
//
//  Created by Eduard Ani on 18.03.2023.
//

import Foundation

struct Pokemon: Decodable, Hashable {
    let name: String
    let url: URL
}
