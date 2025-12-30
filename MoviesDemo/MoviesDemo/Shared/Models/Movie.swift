//
//  Movie.swift
//  MoviesDemo
//
//  Created by Vishvesh Lad on 30/12/25.
//

import Foundation

public struct Movie: Identifiable, Codable, Hashable {
    public let id: Int
    public let name: String
    public let summary: String?
    public let image: ImageInfo?
    public let rating: Rating?

    public struct ImageInfo: Codable, Hashable {
        public let medium: String?
        public let original: String?
    }

    public struct Rating: Codable, Hashable {
        public let average: Double?
    }
}
