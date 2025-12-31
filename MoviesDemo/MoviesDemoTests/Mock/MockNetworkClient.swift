//
//  MockNetworkClient.swift
//  MoviesDemoTests
//
//  Created by Vishvesh Lad on 01/01/26.
//

import Foundation
@testable import MoviesDemo

final class MockNetworkClient: NetworkClientProtocol {
    
    var result: Result<Data, Error>?
    
    func request<T>(_ endPoint: APIEndpoints) async throws -> T where T : Decodable {
        switch result {
            case .success(let data):
            return try JSONDecoder().decode(T.self, from: data)
        case .failure(let error):
            throw error
        case .none:
            fatalError("Result not set")
        }
    }    
}
