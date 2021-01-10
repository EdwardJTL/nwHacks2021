//
//  TrendingSkillView.swift
//  nwHacks2021
//
//  Created by Martin Yushko on 2021-01-09.
//

import SwiftUI

struct TrendingSkillCellView: View {
    let trendingSkill: Skill
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            
            Group {
                if let safeImage = trendingSkill.image {
                    safeImage
                        .resizable()
                } else {
                    Image("backflip")
                        .resizable()
                }
            }
            .aspectRatio(1, contentMode: .fill)
            LinearGradient(gradient: Gradient(colors: [.clear, Color.black.opacity(0.5)]), startPoint: .top, endPoint: .bottom)
            VStack(alignment: .leading) {
                HStack {
                    Text(trendingSkill.title)
                    .foregroundColor(.white)
                    .bold()
                    Spacer()
                    Image(systemName: "person.crop.circle.badge.checkmark")
                        .resizable()
                        .aspectRatio(1, contentMode: .fit)
                        .foregroundColor(.white)
                        .frame(width: 24, height: 24)
                    if let safeCompletedCount = trendingSkill.completedCount {
                        Text("\(safeCompletedCount)")
                            .foregroundColor(.white)
                    } else {
                        Text("0")
                            .foregroundColor(.white)
                    }
                }
            }
            .padding()
        }
        .aspectRatio(1, contentMode: .fit)
        .cornerRadius(10.0, antialiased: true)
    }
}

struct TrendingSkillCellView_Previews: PreviewProvider {
    static var previews: some View {
        TrendingSkillCellView(trendingSkill: Skill(title: "Test Skill", categories: ["Test"], completedCount: 10, estimatedTime: TimeInterval(180), description: "DescriptionTest DescriptionTest DescriptionTest DescriptionTest DescriptionTest Description", image: Image("knitting"), videoURL: nil))
    }
}
