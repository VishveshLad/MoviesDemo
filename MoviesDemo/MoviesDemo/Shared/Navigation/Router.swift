//
//  Router.swift
//  MoviesDemo
//
//  Created by Vishvesh Lad on 30/12/25.
//

import Foundation
import SwiftUI
internal import Combine

final class Router: ObservableObject {
    enum Route: Hashable {
        case movieDetails(id: Int)
    }
    
    @Published var path = NavigationPath()
    
    func push(_ route: Route) {
        self.path.append(route)
    }
    
    func popToRoot() {
        self.path = NavigationPath()
    }
}
