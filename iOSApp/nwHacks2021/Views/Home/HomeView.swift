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

struct PreviewInProgressSkills {
    var data: [InProgressSkill]
    
    init() {
        data = []
        for _ in 0..<10 {
            data.append(InProgressSkill(skill: Skill(title: "Backflip", body: [], categories: []), startedAt: Date()))
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView().environmentObject(InProgressSkills(skills: PreviewInProgressSkills().data))
    }
}
