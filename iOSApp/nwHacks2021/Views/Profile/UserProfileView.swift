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
    
    let profileImageSize: CGFloat = 80
    let iconSize: CGFloat = 20
    
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
                HStack {
                    Image(systemName: "flame")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: iconSize)
                        .foregroundColor(.orange)
                    Text("\(userObject.user.streaks)")
                    
                    Spacer()
                    
                    Image(systemName: "person.2")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: iconSize)
                        .foregroundColor(.blue)
                    Text("\(userObject.user.followers.count)")
                    
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
                        }
                    })
                }
            }
            .padding(.horizontal)
        }
    }
}

struct UserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileView()
            .environmentObject(UserData())
    }
}
