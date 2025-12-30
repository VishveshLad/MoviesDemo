//
//  MoviesListViewModel.swift
//  MoviesDemo
//
//  Created by Vishvesh Lad on 30/12/25.
//

import Foundation
internal import Combine

@MainActor
final class MoviesListViewModel: ObservableObject {
    enum ViewState {
        case idle
        case loading
        case empty
        case loaded([Movie])
        case error(String)
    }
    
    @Published private(set) var state: ViewState = .idle
    
    private let service: MovieServiceProtocol
    
    init(service: MovieServiceProtocol) {
        self.service = service
    }
    
    func fetchMovies() async {
        state = .loading
        
        do {
            let movies = try await self.service.fetchMovies()
            state = movies.isEmpty ? .empty : .loaded(movies)
        }catch{
            state = .error(error.localizedDescription)
        }
    }
}
