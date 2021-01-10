//
//  PostCardView.swift
//  nwHacks2021
//
//  Created by Edward Luo on 2021-01-10.
//

import Combine
import Foundation
import SwiftUI

struct PostCardView: View {
    
    @EnvironmentObject var currentUser: UserData
    @State var clapped: Bool = false
    @State var comment: String = ""
    
    let post: Post
    
    let cornerRadius: CGFloat = 20
    let shadowRadius: CGFloat = 10
    let profileImageSize: CGFloat = 40
    
    let contentWidthRatio: CGFloat = 0.85
    
    let sendIconHeight: CGFloat = 30
    
    var body: some View {
        VStack {
            // Pfp, name, clap
            HStack(alignment: .center) {
                // Profile Image
                Group {
                    if let safeImage = post.user.photo {
                        safeImage
                            .resizable()
                    } else {
                        Image(systemName: "person.circle.fill")
                            .resizable()
                    }
                }
                .aspectRatio(1, contentMode: .fill)
                .frame(width: profileImageSize, height: profileImageSize)
                .clipShape(Circle())
                
                Text(post.user.userName)
                    .font(.headline)
                    .foregroundColor(.blue)
                
                Spacer()
                
                Button(action: {
                    clapped.toggle()
                }, label: {
                    Group {
                        if !clapped {
                            Image(systemName: "hands.clap")
                                .resizable()
                                .foregroundColor(.systemGray)
                        } else {
                            Image(systemName: "hands.clap.fill")
                                .resizable()
                                .foregroundColor(.yellow)
                        }
                    }
                    .aspectRatio(1, contentMode: .fit)
                    .frame(width: profileImageSize, height: profileImageSize, alignment: .center)
                })
            }
            .padding([.horizontal, .top])
            
            Divider()
            
            // Text and Media
            VStack(alignment: .center) {
                
                // Skill
                HStack{
                    VStack(alignment: .leading) {
                        Text("Today, I worked on")
                            .font(.title3)
                            .foregroundColor(.label)
                            .fontWeight(.bold)
                        Text(post.inProgressSkill.skill.title)
                            .font(.title)
                            .foregroundColor(.blue)
                            .fontWeight(.heavy)
                    }
                    Spacer()
                }
                .padding(.bottom, 10)
                
                Text(post.description)
                    .foregroundColor(.label)
                    .font(.body)
                    .fixedSize(horizontal: false, vertical: true)
                    .multilineTextAlignment(.leading)
                    .allowsTightening(true)
                    .lineLimit(3)
                    .truncationMode(.tail)
            
                //TODO right now this is a static picture but it should be playable media such as a video
                Group {
                    if let safeImage = post.image {
                        safeImage
                            .resizable()
                    } else {
                        Image("backflip")
                            .resizable()
                    }
                }
                .aspectRatio(1, contentMode: .fill)
                .frame(width: UIScreen.screenWidth * contentWidthRatio)
                .clipShape(RoundedRectangle(cornerRadius: 25))
                
            }
            .frame(width: UIScreen.screenWidth * contentWidthRatio)
            .padding()
            
            Divider()
            
            // Text Field
            
            HStack {
                TextField("Celebrate with \(post.user.firstName)!", text: $comment, onEditingChanged: { _ in
                }) {
                    // on commit
                }
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .foregroundColor(.blue)
                
                Button(action: {
                    
                }, label: {
                    Group {
                        if comment.isEmpty {
                            Image(systemName: "paperplane")
                                .resizable()
                                .foregroundColor(.systemGray)
                        } else {
                            Image(systemName: "paperplane.fill")
                                .resizable()
                                .foregroundColor(.blue)
                        }
                    }
                    .aspectRatio(1, contentMode: .fit)
                    .frame(height: sendIconHeight)
                })
            }
            .padding([.horizontal, .bottom])
        }
        .background(Color.systemBackground)
        .cornerRadius(cornerRadius)
        .shadow(radius: shadowRadius)
        
    }
}

struct PostCardView_Previews: PreviewProvider {
    static var previews: some View {
        PostCardView(post: PreviewPost().data)
            .environmentObject(UserData(user: User.defaultUser()))
    }
}
