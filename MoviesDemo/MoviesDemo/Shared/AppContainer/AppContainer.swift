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
    let reachability: NetworkReachability
    
    init(router: AppRouter, network: NetworkClientProtocol = NetworkClient(), reachability: NetworkReachability = NetworkReachability()) {
        // Core
        self.router = router
        self.network = network
        self.reachability = reachability
    }
}
