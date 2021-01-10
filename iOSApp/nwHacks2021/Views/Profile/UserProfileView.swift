//
//  UserProfileView.swift
//  nwHacks2021
//
//  Created by Edward Luo on 2021-01-09.
//

import Foundation
import SwiftUI

struct UserProfileView: View {
    
    @EnvironmentObject var userObject: UserData
    
    let profileImageSize: CGFloat = 88
    let iconSize: CGFloat = 22
    
    let gridPadding: CGFloat = 5
    var columns: [GridItem]
        
    init() {
        columns = [GridItem(.adaptive(minimum: 100), spacing: gridPadding)]
    }
    
    var body: some View {
        ScrollView {
            VStack {
                HStack(alignment: .top) {
                    // Profile Image
                    Group {
                        if let safeImage = userObject.user.photo {
                            safeImage
                                .resizable()
                        } else {
                            Image(systemName: "person.circle.fill")
                                .resizable()
                        }
                    }
                    .aspectRatio(1, contentMode: .fill)
                    .frame(width: profileImageSize)
                    .clipShape(Circle())
                    
                    // Text
                    VStack(alignment: .leading) {
                        HStack {
                            Text(userObject.user.userName)
                                .font(.headline)
                            Spacer()
                            Button(action: {
                                
                            }, label: {
                                Text("Settings")
                                    .font(.body)
                                    .foregroundColor(.white)
                                    .padding(3)
                                    .background(Color.blue)
                                    .cornerRadius(5)
                            })
                        }
                        Text(userObject.user.firstName + " " + (userObject.user.lastName ?? ""))
                            .font(.subheadline)
                        if let safeBio = userObject.user.bio {
                            Text(safeBio)
                                .font(.caption)
                        }
                    }
                }
                // Bar with streak, followers, and stats
                HStack {
                    Image(systemName: "flame")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: iconSize)
                        .foregroundColor(.orange)
                    Text("\(userObject.user.streaks)")
                        .font(.body)
                    
                    Spacer()
                    
                    Image(systemName: "person.2")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: iconSize)
                        .foregroundColor(.blue)
                    Text("\(userObject.user.followers.count)")
                        .font(.body)
                    
                    Spacer()
                    
                    Button(action: {
                        
                    }, label: {
                        HStack {
                            Image(systemName: "chart.bar.xaxis")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(height: iconSize)
                                .foregroundColor(.blue)
                            Text("Stats")
                                .font(.body)
                        }
                    })
                }
                .padding()
                // View of past skills with dates
                skillsGrid
            }
            .padding(.horizontal)
        }
        .padding(.top)
    }
    
    var skillsGrid: some View {
        LazyVGrid(
            columns: columns,
            alignment: .center,
            spacing: gridPadding) {
            ForEach(0..<userObject.user.posts.count) { idx in
                ProfileSkillCellView(post: userObject.user.posts[idx])
                    .aspectRatio(contentMode: .fit)
            }
        }
    }
}

struct ProfileSkillCellView: View {
    let post: Post
    let iconSize: CGFloat = 15
    let cornerRadius: CGFloat = 10
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            ZStack(alignment: .topTrailing) {
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
                HStack {
                    Spacer()
                    Image(systemName: "hands.clap")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: iconSize)
                        .foregroundColor(.white)
                    Text("\(post.clapCount)")
                        .font(.caption)
                        .foregroundColor(.white)
                }
                .padding(5)
                .background(
                    LinearGradient(gradient: Gradient(colors: [.clear, Color.black.opacity(0.5)]), startPoint: .bottom, endPoint: .top)
                )
            }
            LinearGradient(gradient: Gradient(colors: [.clear, Color.black.opacity(0.5)]), startPoint: .top, endPoint: .bottom)
            Text(toDateString(from: post.completionDate!, format: "MMM d"))
                .font(.subheadline)
                .foregroundColor(.white)
                .padding(5)
        }
        .cornerRadius(cornerRadius)
    }
}

struct UserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileView()
            .environmentObject(UserData(user: PreviewUser().data))
    }
}
