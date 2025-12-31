//
//  PlaceholderImage.swift
//  MoviesDemo
//
//  Created by Vishvesh Lad on 31/12/25.
//

import SwiftUI

struct PlaceholderImage: View {
    var body: some View {
        Image(systemName: "photo")
            .resizable()
            .scaledToFit()
            .foregroundStyle(Color.gray.opacity(0.3))
            .clipped()
            .cornerRadius(6)
    }
}

#Preview {
    PlaceholderImage()
}
