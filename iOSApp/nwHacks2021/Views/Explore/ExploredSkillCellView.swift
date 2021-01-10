//
//  ExploredSkillCellView.swift
//  nwHacks2021
//
//  Created by Martin Yushko on 2021-01-09.
//

import SwiftUI

struct ExploredSkillCellView: View {
    let exploredSkill: Skill
    var body: some View {
        NavigationLink(
            destination: SkillDetailView(skill: exploredSkill, inProgressSkill: nil, learning: false),
            label: {
                content
            })
    }
    var content: some View {
        ZStack(alignment: .bottomLeading) {
            
            Group {
                if let safeImage = exploredSkill.image {
                    safeImage
                        .resizable()
                } else {
                    Image("backflip")
                        .resizable()
                }
            }
            .aspectRatio(1, contentMode: .fill)
            LinearGradient(gradient: Gradient(colors: [.clear, Color.black.opacity(0.5)]), startPoint: .top, endPoint: .bottom)
            VStack(alignment: .center) {
                Text(exploredSkill.title)
                    .foregroundColor(.white)
                    .bold()
            }
        }
        .aspectRatio(1, contentMode: .fit)
        .cornerRadius(8.0, antialiased: true)
    }
}

struct ExploredSkillCellView_Previews: PreviewProvider {
    static var previews: some View {
        ExploredSkillCellView(exploredSkill: Skill(title: "Test Skill", categories: ["Test"], completedCount: 10, estimatedTime: TimeInterval(180), creator: PreviewUser().data, description: "DescriptionTest DescriptionTest DescriptionTest DescriptionTest DescriptionTest Description", image: Image("knitting"), videoURL: nil))
    }
}
