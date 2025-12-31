//
//  TestData.swift
//  MoviesDemoTests
//
//  Created by Vishvesh Lad on 01/01/26.
//

import Foundation

enum TestData {

    static let moviesJSON = """
    [
        {
            "id": 1,
            "name": "Test Movie",
            "rating": { "average": 8.5 },
            "image": {
                "medium": "https://test.com/image.jpg",
                "original": "https://test.com/image.jpg"
            },
            "summary": "<p>Test summary</p>"
        }
    ]
    """.data(using: .utf8)!
}

enum TestJSONDecoder {

    static func decode<T: Decodable>(_ type: T.Type, from data: Data) -> T {
        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            fatalError("Failed to decode test JSON: \(error)")
        }
    }
}
