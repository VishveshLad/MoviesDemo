//
//  MoviesDemoApp.swift
//  MoviesDemo
//
//  Created by Vishvesh Lad on 30/12/25.
//

import SwiftUI

@main
struct MoviesDemoApp: App {
    @StateObject private var router: Router
    private let container: AppContainer

    init() {
        
        /// NOTE: -  @StateObject is a property wrapper, and _router is the wrapper itself.
        /// You must initialize the wrapper, not the wrapped value.
        /// _router  // type: StateObject<Router>
        /// In init, you can only assign to the wrapper, not the wrapped value.
        ///
        /// Here:
        /// _router → the wrapper
        /// StateObject(wrappedValue:) → initializes ownership
        /// SwiftUI now manages lifecycle
        /// Router is created once, not recreated
        ///
        /// 🏆 Interview-level explanation (you can quote this)
        /// @StateObject must be initialized by assigning to its backing storage (_property) inside init.
        /// This ensures SwiftUI owns the object lifecycle and prevents reinitialization during view updates.
        
        let router = Router() // ✅ single source
        _router = StateObject(wrappedValue: router)
        container = AppContainer(
            router: router,
            movieService: MovieService()
        )
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $router.path){
                MoviesListView(viewModel: MoviesListViewModel(service: container.movieService))
                    .navigationDestination(for: Router.Route.self) { route in
                        switch route {
                        case .movieDetails(id: let id):
                            MovieDetailView(viewModel: MovieDetailViewModel(movieId: id, service: container.movieService))
                        }
                    }
            }.environmentObject(container)
        }
    }
}
