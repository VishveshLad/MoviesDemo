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
        case moreDetails(id: Int)
    }
    
    /// NOTE - If required to manage custom root view
    enum AppRoot: Hashable {
        case movieList
    }
    
    @Published var root: AppRoot = .movieList
    @Published var path = NavigationPath()
    @Published private(set) var stack: [AppRoute] = []

    // MARK: - Push (CONTROLLED)
    func push(_ route: AppRoute) {
        stack.append(route)
        path.append(route)
    }

    // MARK: - Pop (CONTROLLED)
    func pop() {
        guard !stack.isEmpty else { return }
        stack.removeLast()
        path.removeLast()
    }

    // MARK: - Native back button sync
    func syncAfterNativePop() {
        print("#### STACK BEFORE ####")
        print(stack)
        guard path.count < stack.count else { return }
        stack.removeLast(stack.count - path.count)
        print("#### STACK AFTER CHANGE ####")
        print(stack)
    }

    // MARK: - Pop to root
    func popToRoot() {
        stack.removeAll()
        path = NavigationPath()
    }

    // MARK: - Pop to specific route
    func popTo(_ target: AppRoute) {
        guard let index = stack.lastIndex(of: target) else {
            popToRoot()
            return
        }

        let removeCount = stack.count - index - 1
        stack.removeLast(removeCount)
        path.removeLast(removeCount)
    }
    
    // MARK: - Root replace
    func replaceRoot(with root: AppRoot) {
        path = NavigationPath()
        self.root = root
    }
}
