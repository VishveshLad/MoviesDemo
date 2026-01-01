//
//  Router.swift
//  MoviesDemo
//
//  Created by Vishvesh Lad on 30/12/25.
//

internal import Combine
import Foundation
import SwiftUI

final class AppRouter: ObservableObject {
    enum AppRoute: Hashable {
        case movieList
        case movieDetails(id: Int)
    }
    
    /// NOTE - If required to manage custom root view
        enum AppRoot: Hashable {
            case movieList
        }
    
    @Published var root: AppRoot = .movieList
    @Published var path = NavigationPath()
    // Your own readable stack
    private(set) var routes: [AppRoute] = []
        
    // MARK: - Push
    func push(_ route: AppRoute) {
        routes.append(route)
        path.append(route)
    }

    // MARK: - Pop one
    func pop() {
        guard !routes.isEmpty else { return }
        routes.removeLast()
        path.removeLast()
    }

    // MARK: - Pop to root
    func popToRoot() {
        routes.removeAll()
        path.removeLast(path.count)
    }
        
    // MARK: - Root replace
    func replaceRoot(with root: AppRoot) {
        path = NavigationPath()
        self.root = root
    }
        
    // MARK: - Pop to specific route (SAFE)
    func popTo(_ target: AppRoute, fallbackToRoot: Bool) {
        guard let index = routes.lastIndex(of: target) else {
            pop() // fallback
            return
        }

        let removeCount = routes.count - index - 1
        routes.removeLast(removeCount)
        path.removeLast(removeCount)
    }
}
