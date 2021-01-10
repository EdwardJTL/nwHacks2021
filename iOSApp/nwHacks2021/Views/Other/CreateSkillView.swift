//
//  CreateSkillView.swift
//  nwHacks2021
//
//  Created by Martin Yushko on 2021-01-10.
//

import SwiftUI
import Combine

struct CreateSkillView: View {
    @State var title: String = ""
    @State var text: String = ""
    @State var image: Image?
    @State var showCaptureImageView: Bool = false
    var body: some View {
        VStack {
            TextField("Title", text: $title)
                .padding(.horizontal)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .frame(height: 100)
            ZStack(alignment: .leading) {
                
                TextEditor(text: $text)
                    .padding(.horizontal)
                        .font(.subheadline)
                
                if text.isEmpty {
                    
                    VStack {
                        Text("Give others a tutorial on the skill!")
                        .font(.custom("Helvetica", size: 16))
                        .padding(.all)
                            .offset(x: 6, y: -6)
                        .foregroundColor(.secondary)
                        Spacer()
                        
                    }
                }
            }
            Button(action: {
                self.showCaptureImageView.toggle()
                            }) {
                                Text("Choose photo/video")
                            }
                            image?.resizable()
                              .frame(height: 250)
                                .clipShape(RoundedRectangle(cornerRadius: 25.0))
                                .padding()
            Spacer()
            if (showCaptureImageView) {
                CaptureImageView(isShown: $showCaptureImageView, image: $image)
            }
            Spacer()
            Button("Share Skill", action: {
                //TODO update backend to indicate user has created new skill
                
            })
            .buttonStyle(GradientBackgroundStyle(startColor: Color.orange, endColor: Color.pink))
            .frame(height: 60)
            .padding()
        }
    }
}

struct CreateSkillView_Previews: PreviewProvider {
    static var previews: some View {
        CreateSkillView()
    }
}
