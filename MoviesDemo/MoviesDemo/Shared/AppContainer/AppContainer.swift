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
    // Core
    let router: AppRouter
    let network: NetworkClientProtocol
    
    init(router: AppRouter, network: NetworkClientProtocol = NetworkClient()) {
        // Core
        self.router = router
        self.network = network
    }
}
