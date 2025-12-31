//
//  MockMovieService.swift
//  MoviesDemoTests
//
//  Created by Vishvesh Lad on 01/01/26.
//

import Foundation
@testable import MoviesDemo

final class MockMovieService: MovieServiceProtocol {
    
    var moviesToReturns = [Movie]()
    var errorToThrow: Error?
    
    func fetchMovies() async throws -> [Movie] {
        if let errorToThrow = errorToThrow {
            throw errorToThrow
        }
        return moviesToReturns
    }
    
    func fetchMovieDetails(id: Int) async throws -> Movie {
        if let errorToThrow = errorToThrow {
            throw errorToThrow
        }
        return moviesToReturns.first(where: { $0.id == id})!
    }
}
