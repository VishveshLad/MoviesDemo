//
//  MovieDetailViewModel.swift
//  MoviesDemo
//
//  Created by Vishvesh Lad on 30/12/25.
//

import Foundation
internal import Combine

final class MovieDetailViewModel: ObservableObject {
    enum ViewState {
        case loading
        case loaded(Movie)
        case error(String)
    }
    
    @Published private(set) var state: ViewState = .loading
    
    private var movieId: Int
    private var service: MovieServiceProtocol
    
    init(movieId: Int, service: MovieServiceProtocol) {
        self.movieId = movieId
        self.service = service
    }
    
    func loadDetails() async {
        do {
            let movie = try await self.service.fetchMovieDetails(id: movieId)
            self.state = .loaded(movie)
        }catch {
            state = .error(error.localizedDescription)
        }
    }
}
