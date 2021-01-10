//
//  ExploreView.swift
//  nwHacks2021
//
//  Created by Martin Yushko on 2021-01-09.
//

import Foundation
import SwiftUI

struct ExploreView: View {
    
    @EnvironmentObject var trendingSkills: TrendingSkills
    @EnvironmentObject var exploreableSkills: ExploreableSkills
    @EnvironmentObject var exploreableCategories: ExploreableCategories
    @State private var searchTerm : String = ""
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                
                //search bar
                SearchBarView(searchText: .constant(""), searchPrompt: "Search...")
                
                Text("Trending this week")
                    .font(Font.largeTitle)
                    .bold()
                    .padding(.horizontal)
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack(spacing: 20) {
                        ForEach(0..<trendingSkills.skills.count) { idx in
                            TrendingSkillCellView(trendingSkill: trendingSkills.skills[idx])
                                .frame(width: 200)
                        }
                    }
                    .fixedSize()
                }
                
                ForEach(0..<exploreableCategories.categories.count) { idx in
                    Divider()
                    Text(exploreableCategories.categories[idx])
                        .font(Font.largeTitle)
                        .bold()
                        .padding(.horizontal)
                    ScrollView(.horizontal, showsIndicators: false) {
                        LazyHStack(spacing: 10) {
                            let filteredSkills = exploreableSkills.skills.filter { skill in
                                return skill.categories.contains(exploreableCategories.categories[idx])
                            }
                            
                            ForEach(0..<filteredSkills.count >> 1) { idx in
                                VStack {
                                    ExploredSkillCellView(exploredSkill: filteredSkills[idx*2])
                                        .padding(.bottom, 4.0)
                                        .frame(width: 100)
                                    ExploredSkillCellView(exploredSkill: filteredSkills[idx*2 + 1])
                                        .frame(width: 100)
                                }
                            }
                            
                            if (filteredSkills.count % 2 == 1) {
                                VStack {
                                    ExploredSkillCellView(exploredSkill: filteredSkills[filteredSkills.count - 1])
                                        .frame(width: 100)
                                    Spacer()
                                }
                            }
                        }
                        .fixedSize()
                    }
                }
                
                Spacer()
            }
        }
    }
}

struct ExploreView_Previews: PreviewProvider {
    static var previews: some View {
        ExploreView()
            .environmentObject(TrendingSkills(skills: PreviewTrendingSkills().data))
            .environmentObject(ExploreableSkills(skills: PreviewExploreableSkills().data))
            .environmentObject(ExploreableCategories(categories: PreviewExploreableCategories().data))
    }
}
