//
//  NetworkError.swift
//  MoviesDemo
//
//  Created by Vishvesh Lad on 30/12/25.
//

import Foundation

public enum NetworkError: LocalizedError {
    case invalidURL
    case invalidResponse
    case httpError(statusCode: Int)
    case decodingFailed(Error)
    case noInternet

    public var errorDescription: String? {
        switch self {
        case .invalidURL: return "Invalid URL"
        case .invalidResponse: return "Invalid server response"
        case .decodingFailed(let error):
            return "Failed to decode data \(error)"
        case .httpError(statusCode: let statusCode):
            return "http error with status code :\(statusCode)"
        case .noInternet:
            return "No Internet Connection"
        }
    }
}
