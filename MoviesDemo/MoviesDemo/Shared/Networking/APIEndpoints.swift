//
//  APIEndpoints.swift
//  MoviesDemo
//
//  Created by Vishvesh Lad on 30/12/25.
//

import Foundation

public enum APIEndpoints {
    
    // MARK: - Cases
    case shows
    case showDetails(id: Int)
    
    // MARK: - Base URL
    private var baseURL: URL {
        guard let url = URL(string: "https://api.tvmaze.com") else { fatalError("Invalid base URL") }
        return url
    }
    
    // MARK: - Path
    private var path: String {
        switch self {
        case .shows:
            // ✅ WORKING endpoint
            // https://api.tvmaze.com/shows
            return "/shows"
        case .showDetails(id: let id):
            // ✅ WORKING endpoint
            // https://api.tvmaze.com/shows/{id}
            return "/shows/\(id)"
        }
    }
    
    // MARK: - Headers
    var headers: [String: String] {
        ["Accept": "application/json"]
    }
    
    // MARK: - HTTP Method
    var method: HTTPMethod {
        switch self {
        case .shows, .showDetails:
            return .get
        }
    }
    
    // MARK: - Final URL
    var url: URL {
        let components = URLComponents(url: baseURL.appendingPathComponent(path), resolvingAgainstBaseURL: false)
        guard let url = components?.url else {
            fatalError("Invalid URL Components")
        }
        return url
    }
}
