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
        ZStack {
            Color.blue
                .edgesIgnoringSafeArea(.all)
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
                    
                    VStack(alignment: .leading) {
                        Text(skill.title)
                            .font(.title)
                            .fontWeight(.medium)
                        Text("by \(posterName)")
                            .font(.subheadline)
                    }
                    
                    Spacer()
                }
                .padding()
                
                ScrollView {
                    VStack {
                        Text(skill.description ?? "No description provided.")
                            .font(.body)
                            .fixedSize(horizontal: false, vertical: true)
                            .multilineTextAlignment(.leading)
                            .truncationMode(.tail)
                            .frame(width: 300)
                    
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
                        
                    }
                    .padding()
                    .foregroundColor(.white)
                }
                HStack{
                    Spacer()
                    Button("Learn", action: {
                        //TODO do something
                    })
                    .buttonStyle(GradientBackgroundStyle(startColor: Color.orange, endColor: Color.pink))
                    .frame(height: 60)
                    .padding()
                }
            }
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
        SkillDetailView(skill: Skill(title: "Test Skill", categories: ["Test"], completedCount: 10, estimatedTime: TimeInterval(180), description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse eu arcu nec mi posuere rutrum quis nec elit. Phasellus blandit viverra molestie. Nam erat metus, fermentum tincidunt fringilla et, gravida id erat. Donec euismod magna lectus, et faucibus augue accumsan sed. Aenean accumsan tincidunt vestibulum. Vivamus sit amet quam eget eros congue scelerisque non ac mauris. Nulla fringilla, justo nec sagittis scelerisque, neque justo tempus tellus, vel suscipit mauris metus vulputate turpis. In vitae neque erat. Sed aliquet rutrum leo, nec blandit enim malesuada quis. Sed suscipit eget felis ac egestas. Integer iaculis nisl rutrum, semper elit eget, volutpat lacus. Ut ut massa mi. Donec efficitur varius convallis. Suspendisse ac tincidunt libero.", image: Image("knitting"), videoURL: nil), posterName: "Test Name")
    }
}
