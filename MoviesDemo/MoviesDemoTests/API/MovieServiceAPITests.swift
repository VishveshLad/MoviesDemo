//
//  MovieServiceAPITests.swift
//  MoviesDemoTests
//
//  Created by Vishvesh Lad on 31/12/25.
//

import XCTest
@testable import MoviesDemo

@MainActor final class MovieServiceAPITests: XCTestCase {

    private var service: MovieService!
    
    override func setUp() {
        super.setUp()
        service = MovieService(network: NetworkClient())
    }
    
    override func tearDown() {
        service = nil
        super.tearDown()
    }

    func test_fetchMovies_returnsNonEmptyList() async throws {
        do{
            let movies = try await service.fetchMovies()
            print(movies.count)
            XCTAssertFalse(movies.isEmpty)
        }
        catch(let error) {
            print(error)
            XCTAssertNotNil(error)
        }
    }
    
    func test_fetchMoviesDetails_returnsNonEmpty() async throws {
        do{
            let movie = try await service.fetchMovieDetails(id: 1)
            print(movie.name)
            XCTAssertNotNil(movie.name)
            XCTAssertEqual("Under the Dome", movie.name)
        }catch(let error) {
            print(error)
            XCTAssertNotNil(error)
        }
    }
    
    func test_fetchMoviesDetails_returnsError() async throws {
        do {
            let _ = try await service.fetchMovieDetails(id: 3913721)
        }catch(let error) {
            print(error)
            XCTAssertNotNil(error)
        }
        
    }

}
