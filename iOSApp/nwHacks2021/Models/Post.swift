//
//  Post.swift
//  nwHacks2021
//
//  Created by Edward Luo on 2021-01-09.
//

import Combine
import Foundation
import SwiftUI

// MARK: - Data types
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

struct Story {
    let user: User
    var images: [Image]
    var seenAll: Bool = false
    var rotating: Bool = false
}

// MARK: - Preview Data Generator
struct PreviewStories {
    var data: [Story]
    
    init() {
        data = []
        for _ in 0..<10 {
            data.append(Story(user: User.defaultUser(), images: [Image("knitting"), Image("backflip")]))
        }
    }
}

// MARK: - Observable Data Containers
class Stories: ObservableObject {
    @Published var data: [Story]
    
    init(stories: [Story]? = nil) {
        self.data = stories ?? []
    }
}
