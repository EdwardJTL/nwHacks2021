//
//  Post.swift
//  nwHacks2021
//
//  Created by Edward Luo on 2021-01-09.
//

import Foundation

struct Post {
    let user: User
    let inProgressSkill: InProgressSkill
    let comments: [Comment]
    let clapCount: Int
    let completionDate: Date
}

struct Comment {
    let user: User
    let body: String
    let timestamp: Date?
}
