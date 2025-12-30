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
    case decodingFailed

    public var errorDescription: String? {
        switch self {
        case .invalidURL: return "Invalid URL"
        case .invalidResponse: return "Invalid server response"
        case .decodingFailed: return "Failed to decode data"
        }
    }
}
