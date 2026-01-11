//
//  NetworkClient.swift
//  MoviesDemo
//
//  Created by Vishvesh Lad on 30/12/25.
//

import Foundation

public protocol NetworkClientProtocol {
    func request<T: Decodable>(_ endPoint: APIEndpoints) async throws -> T
}

public final class NetworkClient: NetworkClientProtocol {
    private let session: URLSession
    private let decoder: JSONDecoder
    private let reachability: NetworkReachability
    
   init(session: URLSession = .shared, reachability: NetworkReachability = NetworkReachability()) {
        self.session = session
        self.decoder = JSONDecoder()
        self.reachability = reachability
    }
    
    public func request<T: Decodable>(_ endPoint: APIEndpoints) async throws -> T {
        // ✅ Step 1: Check Internet Connection
        guard reachability.status == .connected else {
            throw NetworkError.noInternet
        }

        var request = URLRequest(url: endPoint.url)
        request.httpMethod = endPoint.method.rawValue
        request.allHTTPHeaderFields = endPoint.headers
        request.timeoutInterval = 30
        
        let (data, response) = try await session.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }
        
        guard (200...299).contains(httpResponse.statusCode) else {
            throw NetworkError.httpError(statusCode: httpResponse.statusCode)
        }
        
        do {
            return try decoder.decode(T.self, from: data)
        } catch {
            throw NetworkError.decodingFailed(error)
        }
    }
}
