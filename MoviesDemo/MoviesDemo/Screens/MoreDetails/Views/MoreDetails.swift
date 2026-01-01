//
//  MoreDetails.swift
//  MoviesDemo
//
//  Created by Vishvesh Lad on 01/01/26.
//

import SwiftUI

struct MoreDetails: View {
    @EnvironmentObject private var container: AppContainer
    private var movieId: Int
    
    init(movieId: Int) {
        self.movieId = movieId
    }
    
    var body: some View {
        Button {
            container.router.popTo(.movieDetails(id: movieId))
        } label: {
            VStack(spacing: 20) {
                Text("THIS FEATURE UNDER DEVELOPMENT")
                    .foregroundStyle(.red)
                    .font(.largeTitle)
                Text("Back To Details")
                    .font(.title)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(.yellow)
                    .cornerRadius(10)
            }.padding()
        }
    }
}

#Preview {
    MoreDetails(movieId: 1)
}
