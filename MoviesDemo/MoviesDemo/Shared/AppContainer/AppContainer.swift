//
//  AppContainer.swift
//  MoviesDemo
//
//  Created by Vishvesh Lad on 30/12/25.
//

import Foundation
import SwiftUI
internal import Combine

final class AppContainer: ObservableObject {
    let router: Router
    let movieService: MovieServiceProtocol
    
    init(router: Router, movieService: MovieServiceProtocol) {
        self.router = router
        self.movieService = movieService    
    }
}
