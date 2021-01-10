//
//  User.swift
//  nwHacks2021
//
//  Created by Edward Luo on 2021-01-09.
//

import Alamofire
import Combine
import Foundation
import SwiftUI
import SwiftyJSON

// MARK: - Data types
struct User {
    let userName: String
    
    var firstName: String
    var lastName: String?
    var email: String
    var photo: Image?
    
    var bio: String?
    var interests: [String]
    
    var posts: [Post]
    var streaks: Int
    
    var followers: [String]
    
    static func defaultUser() -> User {
        return User(userName: "aihli",
                    firstName: "Alice",
                    lastName: "Li",
                    email: "tester@McTest.face",
                    photo: Image("alice"),
                    bio: "This is her bio!",
                    interests: ["potato"],
                    posts: [],
                    streaks: 10,
                    followers: [])
    }
}


// MARK: - Preview Data Generator
struct PreviewUser {
    var data: User
    
    init() {
        data = User.defaultUser()
        for _ in 0..<40 {
            let post = PreviewCompletedPost().data
            data.posts.append(post)
        }
    }
}

// MARK: - Observable Data Containers
class UserData: ObservableObject {
    @Published var user: User
    
    init(user: User? = nil) {
        self.user = user ?? User.defaultUser()
    }
    
    func refreshUser() {
        // basic info
        AF.request(buildGETProfile(userID: user.userName), method: .get).validate().responseJSON { [weak self] (response) in
            guard let self = self else { return }
            let profileJSON: JSON = JSON(response.value!)
            
            self.user.firstName = profileJSON["name"].stringValue.components(separatedBy: " ").first ?? ""
            self.user.lastName = profileJSON["name"].stringValue.components(separatedBy: " ").last ?? ""
            self.user.bio = profileJSON["biography"].stringValue
            self.user.interests = profileJSON["interests"].arrayValue.map { $0.stringValue}
        }
        
        // followers
        AF.request(buildGETFriendEndpoint(userID: user.userName), method: .get).validate().responseJSON { [weak self] (response) in
            guard let self = self else { return }
            let friendsJSON: JSON = JSON(response.value!)
            
            self.user.followers = friendsJSON["friends"].arrayValue.map { $0.stringValue}
        }
    }
}
