//
//  MoviesListView.swift
//  MoviesDemo
//
//  Created by Vishvesh Lad on 30/12/25.
//

import SwiftUI

struct MoviesListView: View {
    @StateObject private var viewModel: MoviesListViewModel
    @EnvironmentObject private var container: AppContainer
    
    init(viewModel: MoviesListViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        content
            .navigationTitle("Movies")
            .task {
                await viewModel.fetchMovies()
            }
    }
    
    @ViewBuilder
    private var content: some View {
        switch viewModel.state {
        case .idle,.loading:
            ProgressView("Loading...")
        case .empty:
            Text("No movies available.")
        case .loaded(let movies):
            List(movies) { movie in
                Button {
                    container.router.push(.movieDetails(id: movie.id))
                } label: {
                    HStack(alignment: .top,spacing: 20){
                        AsyncImage(url: URL(string: movie.image?.medium ?? "")) { phase in
                            switch phase {
                            case .empty:
                                ProgressView()
                                    .frame(width: 60, height: 90)
                            case .success(let image):
                                image
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 60,height: 90)
                                    .clipped()
                                    .cornerRadius(6)
                            case .failure:
                                placeholderImage.frame(width: 60,height: 90)
                            default:
                                placeholderImage.frame(width: 60,height: 90)
                            }
                        }
                        VStack(alignment: .leading, spacing: 6) {
                            Text(movie.name)
                                .font(.title)
                            if let rating = movie.rating?.average {
                                Text("⭐️ \(rating, specifier: "%.1f")")
                                    .font(.subheadline)
                                    .foregroundStyle(Color.secondary)
                            }
                        }
                    }
                }
            }
        case .error(let message):
            Text(message).foregroundStyle(Color.red)
        }
    }
}

#Preview {
    MoviesListView(viewModel: MoviesListViewModel(service: MovieService()))
}
