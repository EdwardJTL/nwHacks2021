//
//  User.swift
//  nwHacks2021
//
//  Created by Edward Luo on 2021-01-09.
//

import Foundation
import SwiftUI

struct User {
    let UserName: String
    
    var firstName: String
    var lastName: String?
    var email: String
    var photo: Image?
    
    var posts: [Post]
    var streaks: Int
    
    var followers: [User]
}
