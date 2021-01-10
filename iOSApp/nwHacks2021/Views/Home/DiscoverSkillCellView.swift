//
//  DiscoverSkillCellView.swift
//  nwHacks2021
//
//  Created by Edward Luo on 2021-01-09.
//

import Foundation
import SwiftUI

struct DiscoverSkillCellView: View {
    let skill: Skill
    let imageSize: CGFloat = 80
    let iconSize: CGFloat = 20
    let roundedCorner: CGFloat = 10
    
    var body: some View {
        NavigationLink(
            destination: SkillDetailView(skill: skill, inProgressSkill: nil, posterName: "Discovered User", learning: false),
            label: {
                content
            })
    }
    
    
    var content: some View {
        HStack {
            Group {
                if let safeImage = skill.image {
                    safeImage
                        .resizable()
                } else {
                    Image("backflip")
                        .resizable()
                }
            }
            .aspectRatio(1, contentMode: .fill)
            .frame(width: imageSize, height: imageSize, alignment: .leading)
            .cornerRadius(10)
            
            VStack(alignment: .leading) {
                Text(skill.title)
                    .font(.headline)
                    .foregroundColor(.white)
                if let safeDescription = skill.description {
                    Text(safeDescription)
                        .font(.subheadline)
                        .foregroundColor(.white)
                }
                HStack(spacing: 20) {
                    if let safeTime = skill.estimatedTime {
                        HStack {
                            Image(systemName: "timer")
                                .resizable()
                                .aspectRatio(1, contentMode: .fit)
                                .foregroundColor(.white)
                            Text(toIntervalString(from: safeTime))
                                .font(.caption)
                                .foregroundColor(.white)
                        }
                        .frame(height: iconSize)
                    }
                    if let safeCount = skill.completedCount {
                        HStack {
                            Image(systemName: "person.crop.circle.badge.checkmark")
                                .resizable()
                                .aspectRatio(1, contentMode: .fit)
                                .foregroundColor(.white)
                            Text("\(safeCount)")
                                .font(.caption)
                                .foregroundColor(.white)
                        }
                        .frame(height: iconSize)
                    }
                    if let firstCategory = skill.categories.first {
                        Text(firstCategory)
                            .font(.caption)
                            .foregroundColor(.white)
                            .padding(2)
                            .overlay(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(Color.white, lineWidth: 2)
                            )
                            .frame(height: iconSize)
                    }
                }
            }
            Spacer()
        }
        .padding(10)
        .background(Color.blue)
        .cornerRadius(roundedCorner, antialiased: true)
    }
}

struct DiscoverSkillCellView_Previews: PreviewProvider {
    static var previews: some View {
        DiscoverSkillCellView(skill: Skill(title: "Test Skill", categories: ["Test"], completedCount: 10, estimatedTime: TimeInterval(180), description: "Test Description", image: Image("knitting"), videoURL: nil))
    }
}
