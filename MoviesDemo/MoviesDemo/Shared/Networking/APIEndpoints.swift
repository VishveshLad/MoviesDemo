//
//  APIEndpoints.swift
//  MoviesDemo
//
//  Created by Vishvesh Lad on 30/12/25.
//

import Foundation

public enum APIEndpoints {
    static let baseURL = "https://api.tvmaze.com"

    static func movies() -> URL? {
        // ✅ WORKING endpoint
        // https://api.tvmaze.com/shows
        URL(string: baseURL + "/shows")
    }

    static func movieDetails(id: Int) -> URL? {
        // ✅ WORKING endpoint
        // https://api.tvmaze.com/shows/{id}
        URL(string: baseURL + "/shows/\(id)")
    }
}
