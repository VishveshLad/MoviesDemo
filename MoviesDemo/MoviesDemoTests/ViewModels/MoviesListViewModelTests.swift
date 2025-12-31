//
//  MoviesListViewModelTests.swift
//  MoviesDemoTests
//
//  Created by Vishvesh Lad on 01/01/26.
//

import XCTest
@testable import MoviesDemo

@MainActor
final class MoviesListViewModelTests: XCTestCase {
    
    private var service: MockMovieService!
    private var viewModel: MoviesListViewModel!
    
    override func setUp() {
        super.setUp()
        service = MockMovieService()
        viewModel = MoviesListViewModel(service: service!)
    }
    
    override func tearDown() {
        service = nil
        viewModel = nil
        super.tearDown()
    }

    func test_loadMovies_success_setLoadState() async 	{
        service.moviesToReturns = TestJSONDecoder.decode([Movie].self, from: TestData.moviesJSON)
       
        await viewModel.fetchMovies()
       
        guard case .loaded(let movies) = viewModel.state else {
            XCTFail("State should be .loaded")
            return
        }
       
        XCTAssertEqual(movies.count, 1)
    }

    func test_loadMovies_empty_setsEmptyState() async {
        service.moviesToReturns = []

        await viewModel.fetchMovies()

        switch viewModel.state {
        case .empty:
            XCTAssertTrue(true)
        default:
            XCTFail("Expected state to be .empty, got \(viewModel.state)")
        }
    }

    
    func test_loadMovies_error_setsErrorState() async {
        service.errorToThrow = URLError(.badServerResponse)

        await viewModel.fetchMovies()

        guard case .error = viewModel.state else {
            XCTFail("Expected error state")
            return
        }
    }
}
