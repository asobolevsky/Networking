//
//  NetworkAgent.swift
//  FootBowl
//
//  Created by Aleksei Sobolevskii on 2024-06-13.
//

import Foundation

public struct NetworkAgent {
    public func performRequest<T: Decodable>(for endpoint: Endpoint) async throws -> T {
        let (data, _) = try await URLSession.shared.data(for: endpoint.buildRequest(with: ""))
        return try JSONDecoder().decode(T.self, from: data)
    }
}
