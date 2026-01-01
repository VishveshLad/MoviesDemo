//
//  AppContainer.swift
//  MoviesDemo
//
//  Created by Vishvesh Lad on 30/12/25.
//

internal import Combine
import Foundation
import SwiftUI

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
