//
//  MovieDetailViewModelTest.swift
//  MoviesDemoTests
//
//  Created by Vishvesh Lad on 01/01/26.
//

import XCTest
@testable import MoviesDemo

@MainActor
final class MovieDetailViewModelTest: XCTestCase {

    private var service: MockMovieService!
    private var viewModel: MovieDetailViewModel!
    
    override func setUp() {
        super.setUp()
        service = MockMovieService()
        viewModel = MovieDetailViewModel(movieId: 1, service: service!)
    }
    
    override func tearDown() {
        service = nil
        viewModel = nil
        super.tearDown()
    }
    
    // MARK: - Initial State

    func test_init_setsIdleState() {
        switch viewModel.state {
        case .loading:
            XCTAssertTrue(true)
        default:
            XCTFail("Expected initial state to be .loading")
        }
    }

    // MARK: - Success Case

    func test_loadMovieDetail_success_setsLoadedState() async {
        let movies: [Movie] = TestJSONDecoder.decode([Movie].self, from: TestData.moviesJSON)
        service.moviesToReturns = movies

        await viewModel.loadDetails()

        switch viewModel.state {
            case .loaded(let movie):
                XCTAssertEqual(movie.id, 1)
                XCTAssertEqual(movie.name, "Test Movie")
                XCTAssertEqual(movie.rating?.average, 8.5)
                XCTAssertEqual(movie.image?.medium, "https://test.com/image.jpg")
                XCTAssertTrue(((movie.summary?.contains("Test movie")) != nil))
            default:
                XCTFail("Expected .loaded state")
        }
    }

    // MARK: - Error Case

    func test_loadMovieDetail_failure_setsErrorState() async {
        service.errorToThrow = URLError(.badServerResponse)

        await viewModel.loadDetails()

        switch viewModel.state {
        case .error(let message):
            XCTAssertFalse(message.isEmpty)
        default:
            XCTFail("Expected .error state")
        }
    }
}
