//
//  AppAlert.swift
//  MoviesDemo
//
//  Created by Vishvesh Lad on 11/01/26.
//

import Foundation

struct AppAlert: Identifiable {
    var id: UUID
    var title: String
    var message: String
    
    init(id: UUID = UUID(), title: String, message: String) {
        self.id = id
        self.title = title
        self.message = message
    }
}
