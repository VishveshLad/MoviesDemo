//
//  RootView.swift
//  MoviesDemo
//
//  Created by Vishvesh Lad on 31/12/25.
//

import SwiftUI

struct RootView: View {
    @EnvironmentObject var container: AppContainer
    @EnvironmentObject var router: AppRouter
    
    var body: some View {
        NavigationStack(path: $router.path){
            rootView
                .navigationDestination(for: AppRouter.AppRoute.self) { route in
                    destination(for: route)
                }
        }
    }
}

private extension RootView {

    @ViewBuilder
    private var rootView: some View {
        switch router.root {
        case .movieList:
            MoviesListView(viewModel: MoviesListViewModel(service: container.movieService))
        }
    }
    @ViewBuilder
    func destination(for route: AppRouter.AppRoute) -> some View {
        switch route {
        case .movieList:
            MoviesListView(viewModel: MoviesListViewModel(service: container.movieService))
        case .movieDetails(id: let id):
            MovieDetailView(viewModel: MovieDetailViewModel(movieId: id, service: container.movieService))
        }
    }
}

#Preview {
    let router = AppRouter()
    let container = AppContainer(router: router)

    RootView()
        .environmentObject(router)
        .environmentObject(container)
}

