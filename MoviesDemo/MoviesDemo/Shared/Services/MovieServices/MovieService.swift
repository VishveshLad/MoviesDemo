//
//  MovieService.swift
//  MoviesDemo
//
//  Created by Vishvesh Lad on 30/12/25.
//

import Foundation

public protocol MovieServiceProtocol {
    func fetchMovies() async throws -> [Movie]
    func fetchMovieDetails(id: Int) async throws -> Movie
}

public final class MovieService: MovieServiceProtocol {
    private let network: NetworkClientProtocol
    
    public init (network: NetworkClientProtocol = NetworkClient()) {
        self.network = network
    }
    
    public func fetchMovies() async throws -> [Movie] {
        return try await network.request(.shows)
    }
    
    public func fetchMovieDetails(id: Int) async throws -> Movie {
        return try await network.request(.showDetails(id: id))
    }
}
