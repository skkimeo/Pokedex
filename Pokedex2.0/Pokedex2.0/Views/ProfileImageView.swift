//
//  ProfileImageView.swift
//  Pokedex2.0
//
//  Created by sun on 2021/10/29.
//

import SwiftUI

struct ProfileImageView: View {
    let image: Image?
    
    var body: some View {
        ZStack {
                if image != nil {
                    image!.resizable()
                } else {
                    ProgressView()
//                    Color(.systemIndigo)
//                    Image(systemName: "star.fill")
//                        .font(.largeTitle)
//                        .foregroundColor(.white)
            }
//            .resizable()
//            .aspectRatio(contentMode: .fill)
        }
        .frame(width: 150, height: 150)
        .cornerRadius(8)
        .clipped()
        
    }
}














struct profileImageView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
