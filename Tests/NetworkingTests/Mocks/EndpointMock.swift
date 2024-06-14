//
//  File.swift
//  
//
//  Created by Aleksei Sobolevskii on 2024-06-13.
//

import Testing
@testable import Networking

struct MockEndpoint: Endpoint {
    var path = ""
    var method: HTTPMethod = .GET
    var headers: [String : String]?
    var parameters: [String : String]?

}
