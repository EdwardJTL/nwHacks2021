//
//  SkillDetailView.swift
//  nwHacks2021
//
//  Created by Martin Yushko on 2021-01-09.
//

import SwiftUI

struct SkillDetailView: View {
    let skill: Skill
    let posterName: String //TODO replace with user
    
    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    Group {
                        if let safeImage = skill.image {
                            // TODO change to poster user image
                            safeImage
                                .resizable()
                        } else {
                            Image("backflip")
                                .resizable()
                        }
                    }
                    .aspectRatio(1, contentMode: .fill)
                    .frame(width: 60, height: 60, alignment: .leading)
                    .clipShape(Circle())
                    
                    VStack {
                        Text(posterName)
                        Text(skill.title).fontWeight(.medium).font(.title)
                    }
                    
                    
                    Spacer()
                }
                
                if let safeText = skill.description {
                    Text(safeText)
                } else {
                    Text("No description provided.")
                }
            
                //TODO right now this is a static picture but it should be playable media such as a video
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
                .frame(width: 300, height: 200)
                .clipShape(RoundedRectangle(cornerRadius: 25))
                
                HStack{
                    Spacer()
                    Button("Learn", action: {
                        //TODO do something
                    })
                    .buttonStyle(GradientBackgroundStyle(startColor: Color.orange, endColor: Color.pink))
                    .frame(width: 140, height: 60)
                    .offset(y: 10.0)
                }
            
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
        }
    }
    
}

struct GradientBackgroundStyle: ButtonStyle {
 
    var startColor: Color
    var endColor: Color
    
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .frame(maxWidth: .infinity)
            .padding()
            .foregroundColor(.white)
            .background(LinearGradient(gradient: Gradient(colors: [startColor, endColor]), startPoint: .leading, endPoint: .trailing).opacity(configuration.isPressed ? 0.5 : 1))
            .cornerRadius(25)
            .shadow(radius: 10)
            .font(.title)
    }
}

struct SkillDetailView_Previews: PreviewProvider {
    static var previews: some View {
        SkillDetailView(skill: Skill(title: "Test Skill", body: [], categories: ["Test"], completedCount: 10, estimatedTime: TimeInterval(180), description: "DescriptionTest DescriptionTest DescriptionTest DescriptionTest DescriptionTest Description", image: Image("knitting"), videoURL: nil), posterName: "Test Name")
    }
}
