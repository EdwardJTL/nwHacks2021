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
    @Binding var clapped: Bool
    @Binding var comment: String
    
    let post: Post
    
    let cornerRadius: CGFloat = 20
    let shadowRadius: CGFloat = 10
    let profileImageSize: CGFloat = 40
    
    let contentWidthRatio: CGFloat = 0.85
    
    let sendIconHeight: CGFloat = 30
    
    var titleFiller: String {
        switch post.type {
        case .completed:
            return "Today, I picked up how to"
        case .created:
            return "Hey! Here is how to"
        case .started:
            return "Today, I checked out how to"
        }
    }
    
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
            
            // Body
            NavigationLink(
                destination: PostDetailView(
                    clapped: $clapped,
                    comment: $comment,
                    post: post),
                label: {
                    VStack {
                        
                        Divider()
                        
                        content
                        
                        Divider()
                    }
                })
            
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
    
    var content: some View {
        // Text and Media
        VStack(alignment: .center) {
            
            // Skill
            HStack{
                VStack(alignment: .leading) {
                    Text(titleFiller)
                        .font(.title3)
                        .foregroundColor(.label)
                        .fontWeight(.bold)
                    Text(post.skill.title)
                        .font(.title)
                        .foregroundColor(.blue)
                        .fontWeight(.heavy)
                }
                Spacer()
            }
            .padding(.bottom, 10)
            
            Group {
                if post.type == Post.PostType.created {
                    HStack {
                        Text(post.skill.description)
                            .foregroundColor(.label)
                            .font(.body)
                            .fixedSize(horizontal: false, vertical: true)
                            .multilineTextAlignment(.leading)
                            .allowsTightening(true)
                            .lineLimit(3)
                            .truncationMode(.tail)
                        Spacer()
                    }
                    
                    //TODO right now this is a static picture but it should be playable media such as a video
                    Group {
                        if let safeImage = post.skill.image {
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
                } else if post.type == Post.PostType.started {
                    EmptyView()
                } else if post.type == Post.PostType.completed {
                    HStack {
                        Text(post.description)
                            .foregroundColor(.label)
                            .font(.body)
                            .fixedSize(horizontal: false, vertical: true)
                            .multilineTextAlignment(.leading)
                            .allowsTightening(true)
                            .lineLimit(3)
                            .truncationMode(.tail)
                        Spacer()
                    }
                
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
            }
        }
        .frame(width: UIScreen.screenWidth * contentWidthRatio)
        .padding()
    }
}

struct PostCardView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            PostCardView(
                clapped: .constant(false),
                comment: .constant(""),
                post: PreviewCreatedPost().data)
                .environmentObject(UserData(user: User.defaultUser()))
            PostCardView(
                clapped: .constant(false),
                comment: .constant(""),
                post: PreviewStartedPost().data)
                .environmentObject(UserData(user: User.defaultUser()))
            PostCardView(
                clapped: .constant(false),
                comment: .constant(""),
                post: PreviewCompletedPost().data)
                .environmentObject(UserData(user: User.defaultUser()))
        }
    }
}
