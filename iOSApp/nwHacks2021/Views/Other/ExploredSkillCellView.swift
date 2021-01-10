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
        .cornerRadius(10.0, antialiased: true)
    }
}

struct ExploredSkillCellView_Previews: PreviewProvider {
    static var previews: some View {
        ExploredSkillCellView(exploredSkill: Skill(title: "Test Skill", body: [], categories: ["Test"], completedCount: 10, estimatedTime: TimeInterval(180), description: "DescriptionTest DescriptionTest DescriptionTest DescriptionTest DescriptionTest Description", image: Image("knitting"), videoURL: nil))
    }
}
