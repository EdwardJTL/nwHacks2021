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
    
    static func UserFromID(id: String) -> User {
        return User(userName: id,
                    firstName: id,
                    lastName: "",
                    email: "tester@McTest.face",
                    photo: Image(systemName: "person.crop.circle.fill"),
                    bio: "This is their bio!",
                    interests: ["potato"],
                    posts: [],
                    streaks: 10,
                    followers: [])
    }
    
    static func DemoUsers(id: Int) -> User {
        return User(userName: dummyUsers[id]![0], firstName: dummyUsers[id]![1], lastName: dummyUsers[id]![2],
                    email: "\(dummyUsers[id]![0])@blah.ca",
                    photo: Image(systemName: "person.crop.circle.fill"),
                    bio: "\(dummyUsers[id]![1]) likes \(dummyUsers[id]![3])",
                    interests: [dummyUsers[id]![3]],
                    posts: [],
                    streaks: 5,
                    followers: [])
    }
}

let dummyUsers: [Int: [String]] = [0: ["martha_cooks", "Martha", "Flores", "cooking"], 1: ["jeanie", "Jean", "Richardson", "gardening"],
                                   2: ["lillies", "Lillian", "Parker", "crafts"], 3: ["spooderman", "Miles", "Morales", "gadgets"],
                                   4: ["tats", "Marty", "Greene", "tatto"], 5: ["psyduck", "Ash", "Surge", "pokemon"]]


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
            self.user.streaks = profileJSON["streak"].intValue
        }
        
        // followers
        AF.request(buildGETFriendEndpoint(userID: user.userName), method: .get).validate().responseJSON { [weak self] (response) in
            guard let self = self else { return }
            let friendsJSON: JSON = JSON(response.value!)
            
            self.user.followers = friendsJSON["friends"].arrayValue.map { $0.stringValue}
        }
        
//        // Completed Skills
//        AF.request(buildGETSkills(userID: user.userName), method: .get).validate().responseJSON { [weak self] (response) in
//            guard let self = self else { return }
//            let responseJSON: JSON = JSON(response.value!)
//
//            let skillsJSON = responseJSON["skills"].arrayValue
//
//            skillsJSON.forEach { skillJSON in
//                if skillJSON["completed"].boolValue {
//                    self.user.posts
//                }
//            }
//        }
        
    }
}
