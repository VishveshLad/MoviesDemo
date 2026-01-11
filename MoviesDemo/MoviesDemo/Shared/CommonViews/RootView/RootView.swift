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
    @State private var alert: AppAlert?
    
    var body: some View {
        NavigationStack(path: $router.path) {
            rootView
                .navigationDestination(for: AppRouter.AppRoute.self) { route in
                    destination(for: route)
                }
        }.onChange(of: router.path) { _, _ in
            print("###### PATH CHANGED ######")
            router.syncAfterNativePop()
        }.onChange(of: container.reachability.status) { _, networkStatus in
            manageAlert(networkStatus: networkStatus)
        }.alert(item: $alert) { alert in
            Alert(
                title: Text(alert.title),
                message: Text(alert.message),
                dismissButton: .default(Text("OK"))
            )

        }
    }
}

private extension RootView {

    @ViewBuilder
    private var rootView: some View {
        switch router.root {
        case .movieList:
            MoviesListView(viewModel: MoviesListViewModel(service: MovieService(network: container.network)))
        }
    }
    @ViewBuilder
    func destination(for route: AppRouter.AppRoute) -> some View {
        switch route {
        case .movieList:
            MoviesListView(viewModel: MoviesListViewModel(service: MovieService(network: container.network)))
        case .movieDetails(id: let id):
            MovieDetailView(viewModel: MovieDetailViewModel(movieId: id, service: MovieService(network: container.network)))
        case .moreDetails(id: let id):
            MoreDetails(movieId: id)
        }
    }
    
    func manageAlert(networkStatus: NetworkReachability.NetworkStatus) {
        if networkStatus == .disconnected {
            self.alert = AppAlert(title: "No Internet Connection", message: "Please check your internet connection and try again.")
        } else {
            self.alert = nil
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
