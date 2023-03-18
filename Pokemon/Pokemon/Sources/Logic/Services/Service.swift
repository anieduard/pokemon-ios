//
//  Service.swift
//  Pokemon
//
//  Created by Eduard Ani on 18.03.2023.
//

import Foundation

protocol Service: AnyObject {
    var networkClient: NetworkClientProtocol { get }
    var path: String { get }
    
    init(networkClient: NetworkClientProtocol)
}

extension Service {
    
    var path: String { "" }
    
    var url: URL {
        var components = networkClient.baseURL
        components.path = path
        guard let url = components.url else { fatalError("The URL couldn't be formed from the specified components: \(components).") }
        return url
    }
}
