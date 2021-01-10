//
//  User.swift
//  nwHacks2021
//
//  Created by Edward Luo on 2021-01-09.
//

import Combine
import Foundation
import SwiftUI

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
    
    var followers: [User]
    
    static func defaultUser() -> User {
        return User(userName: "TesterUserName",
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

// MARK: - Observable Data Containers
class UserData: ObservableObject {
    @Published var user: User
    
    init(user: User? = nil) {
        self.user = user ?? User.defaultUser()
    }
}
