//
//  MovieDetailView.swift
//  MoviesDemo
//
//  Created by Vishvesh Lad on 30/12/25.
//

import SwiftUI

struct MovieDetailView: View {
    @EnvironmentObject private var container: AppContainer
    @StateObject var viewModel: MovieDetailViewModel
    
    init(viewModel: MovieDetailViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    var body: some View {
        content
            .navigationTitle("Details")
            .navigationBarTitleDisplayMode(.inline)
            .task {
                await viewModel.loadDetails()
            }
    }
    
    @ViewBuilder
    private var content: some View {
        switch viewModel.state {
        case .loading:
            ProgressView()
        case .loaded(let movie):
            ScrollView {
                VStack(alignment: .center) {
                    AsyncImage(
                        url: URL(string: movie.image?.original ?? "")
                    ) { phase in
                        switch phase {
                        case .empty:
                            ProgressView().frame(height: 250)
                        case .success(let image):
                            image
                                .resizable()
                                .scaledToFit()
                                .cornerRadius(12)
                        case .failure:
                            PlaceholderImage().frame(height: 250)
                        @unknown default:
                            PlaceholderImage()
                                .frame(height: 250)
                        }
                    }
                }.padding()
                VStack(alignment: .leading, spacing: 16) {
                    Button {
                        container.router.push(.moreDetails(id: viewModel.getMovieId()))
                    } label: {
                        Text("More Details")
                            .font(.title)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(.yellow)
                            .cornerRadius(10)
                    }

                    Text(movie.name)
                        .font(.title.bold())

                    if let rating = movie.rating?.average {
                        Text("⭐️ Rating: \(rating, specifier: "%.1f")")
                            .foregroundColor(.secondary)
                    }

                    Text(movie.summary?.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression) ?? "")
                        .font(.body)
                }
                .padding()
            }
        case .error(let message):
            Text(message)
                .foregroundStyle(Color.red)
        }
    }
}

#Preview {
    MovieDetailView(viewModel: MovieDetailViewModel(movieId: 1, service: MovieService(network: NetworkClient())))
}
