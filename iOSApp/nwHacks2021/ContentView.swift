//
//  ContentView.swift
//  nwHacks2021
//
//  Created by Edward Luo on 2021-01-09.
//

import Combine
import SwiftUI

struct ContentView: View {
    @State var selection = 0
    var inProgressSkills: InProgressSkills
    
    init() {
        inProgressSkills = InProgressSkills()
    }
    
    init(inProgressSkills: InProgressSkills) {
        self.inProgressSkills = inProgressSkills
    }
    
    var body: some View {
        TabView(selection: $selection) {
            NavigationView {
                HomeView()
                    .navigationTitle("Home")
            }
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
                .tag(0)
         
            Text("Bookmark Tab")
                .font(.system(size: 30, weight: .bold, design: .rounded))
                .tabItem {
                    Image(systemName: "magnifyingglass.circle")
                    Text("Explore")
                }
                .tag(1)
            
            Text("Add Skill Tab")
                .font(.system(size: 30, weight: .bold, design: .rounded))
                .tabItem {
                    Image(systemName: "pencil.circle")
                    Text("Create")
                }
                .tag(2)
         
            Text("Social Tab")
                .font(.system(size: 30, weight: .bold, design: .rounded))
                .tabItem {
                    Image(systemName: "person.2.circle")
                    Text("Social")
                }
                .tag(3)
         
            Text("Profile Tab")
                .font(.system(size: 30, weight: .bold, design: .rounded))
                .tabItem {
                    Image(systemName: "person.crop.circle")
                    Text("Profile")
                }
                .tag(4)
        }
        .environmentObject(inProgressSkills)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(inProgressSkills: InProgressSkills(skills: PreviewInProgressSkills().data))
    }
}
