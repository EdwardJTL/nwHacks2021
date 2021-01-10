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
    var discoverSkills: DiscoverSkills
    
    var trendingSkills: TrendingSkills
    var exploreableSkills: ExploreableSkills
    var exploreableCategories: ExploreableCategories
    
    var userObject: UserData
    var storyHolder: Stories
    var socialPosts: PostData
    
    
    init(inProgressSkills: InProgressSkills? = nil,
         discoverSkills: DiscoverSkills? = nil,
         trendingSkills: TrendingSkills? = nil,
         exploreableSkills: ExploreableSkills? = nil,
         exploreableCategories: ExploreableCategories? = nil,
         user: UserData? = nil,
         storyHolder: Stories? = nil,
         socialPosts: PostData? = nil) {
        self.inProgressSkills = inProgressSkills ?? InProgressSkills()
        self.discoverSkills = discoverSkills ?? DiscoverSkills()
        
        self.trendingSkills = trendingSkills ?? TrendingSkills()
        self.exploreableSkills = exploreableSkills ?? ExploreableSkills()
        self.exploreableCategories = exploreableCategories ?? ExploreableCategories()
        
        self.userObject = user ?? UserData()
        self.storyHolder = storyHolder ?? Stories()
        self.socialPosts = socialPosts ?? PostData()
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
         
            NavigationView {
                ExploreView()
                    .navigationTitle("Explore")
            }
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
         
            NavigationView{
                SocialView()
                    .navigationTitle("Social")
            }
            .tabItem {
                Image(systemName: "person.2.circle")
                Text("Social")
            }
            .tag(3)
         
            UserProfileView()
                .font(.system(size: 30, weight: .bold, design: .rounded))
                .tabItem {
                    Image(systemName: "person.crop.circle")
                    Text("Profile")
                }
                .tag(4)
                .onAppear(perform: {
                    userObject.refreshUser()
                })
        }
        .environmentObject(inProgressSkills)
        .environmentObject(discoverSkills)
        
        .environmentObject(trendingSkills)
        .environmentObject(exploreableSkills)
        .environmentObject(exploreableCategories)
        
        .environmentObject(userObject)
        .environmentObject(storyHolder)
        .environmentObject(socialPosts)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(inProgressSkills: InProgressSkills(skills: PreviewInProgressSkills().data),
                    discoverSkills: DiscoverSkills(skills: PreviewDiscoverSkills().data),
                    user: UserData(user: PreviewUser().data),
                    storyHolder: Stories(stories: PreviewStories().data))
    }
}
