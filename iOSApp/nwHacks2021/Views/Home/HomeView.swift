//
//  HomeView.swift
//  nwHacks2021
//
//  Created by Edward Luo on 2021-01-09.
//

import Foundation
import SwiftUI

struct HomeView: View {
    @EnvironmentObject var inProgressSkills: InProgressSkills
    @EnvironmentObject var discoverSkills: DiscoverSkills
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                
                Text("Skills in Progress")
                    .font(Font.largeTitle)
                    .bold()
                    .padding(.horizontal)
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack(spacing: 20) {
                        ForEach(0..<inProgressSkills.skills.count) { idx in
                            InProgressCellView(skillInProgress: inProgressSkills.skills[idx])
                                .frame(width: 200)
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
                        ForEach(0..<discoverSkills.skills.count) { idx in
                            DiscoverSkillCellView(skill: discoverSkills.skills[idx])
                        }
                    }
                    .padding(.horizontal)
                }
                
                Spacer()
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView().environmentObject(InProgressSkills(skills: PreviewInProgressSkills().data))
            .environmentObject(DiscoverSkills(skills: PreviewDiscoverSkills().data))
    }
}
