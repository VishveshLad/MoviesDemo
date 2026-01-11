//
//  NetworkReachability.swift
//  MoviesDemo
//
//  Created by Vishvesh Lad on 11/01/26.
//

internal import Combine
import Foundation
import Network

final class NetworkReachability: ObservableObject {
    enum NetworkStatus {
        case connected
        case disconnected
    }
    
    @Published private(set) var status: NetworkStatus = .disconnected
    
    private let monitor: NWPathMonitor
    private let queue = DispatchQueue(label: "NetworkReachabilityQueue")
    
    init(monitor: NWPathMonitor = NWPathMonitor()) {
        self.monitor = monitor
        startMonitoring()
    }
    /// NWPathMonitor runs on a thread → give it a private queue → forward updates to main → safe UI.
    private func startMonitoring() {
        monitor.pathUpdateHandler = { [weak self] (path) in
            Task { @MainActor in
                guard let self else { return }
                self.status = path.status == .satisfied ? .connected : .disconnected
            }
        }
        monitor.start(queue: queue)
    }
    
    deinit {
        monitor.cancel()
    }
}
