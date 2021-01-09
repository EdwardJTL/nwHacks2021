//
//  HomeView.swift
//  nwHacks2021
//
//  Created by Edward Luo on 2021-01-09.
//

import Foundation
import SwiftUI

struct HomeView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                
                Text("Skills in Progress")
                    .font(Font.largeTitle)
                    .bold()
                    .padding(.horizontal)
                ScrollView(.horizontal) {
                    LazyHStack(spacing: 20) {
                        ForEach(0..<10) {
                            Text("Item \($0)")
                        }
                    }
                    .fixedSize()
                }
                
                Divider()
                Text("Discover New Skills")
                    .font(Font.largeTitle)
                    .bold()
                    .padding(.horizontal)
                ScrollView(.vertical) {
                    LazyVStack(alignment:.leading, spacing: 20) {
                        ForEach(0..<20) {
                            Text("Item \($0)")
                        }
                    }
                }
                
                Spacer()
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
