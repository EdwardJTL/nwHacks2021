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
    let skill: Skill
    let type: PostType
    let description: String
    let image: Image?
    let videoURL: String?
    let comments: [Comment]
    let clapCount: Int
    let creationDate: Date?
    let startDate: Date?
    let completionDate: Date?
    
    enum PostType {
        case created
        case started
        case completed
    }
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

struct PreviewCreatedPost {
    var data: Post
    
    init() {
        let user = User.defaultUser()
        let skill = PreviewSkill().data
        let comment = Comment(user: user, body: "This is a test comment", timestamp: Date())
        
        data = Post(user: user,
                    skill: skill,
                    type: .created,
                    description: "",
                    image: nil,
                    videoURL: nil,
                    comments: [comment],
                    clapCount: 10,
                    creationDate: Date(),
                    startDate: nil,
                    completionDate: nil)
    }
}

struct PreviewStartedPost {
    var data: Post
    
    init() {
        let user = User.defaultUser()
        let skill = PreviewSkill().data
        let comment = Comment(user: user, body: "This is a test comment", timestamp: Date())
        
        data = Post(user: user,
                    skill: skill,
                    type: .started,
                    description: "",
                    image: nil,
                    videoURL: nil,
                    comments: [comment],
                    clapCount: 10,
                    creationDate: Date(),
                    startDate: Date(),
                    completionDate: nil)
    }
}

struct PreviewCompletedPost{
    var data: Post
    
    init() {
        let user = User.defaultUser()
        let skill = PreviewSkill().data
        let comment = Comment(user: user, body: "This is a test comment", timestamp: Date())
        
        data = Post(user: user,
                    skill: skill,
                    type: .completed,
                    description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse eu arcu nec mi posuere rutrum quis nec elit. Phasellus blandit viverra molestie. Nam erat metus, fermentum tincidunt fringilla et, gravida id erat. Donec euismod magna lectus, et faucibus augue accumsan sed. Aenean accumsan tincidunt vestibulum. Vivamus sit amet quam eget eros congue scelerisque non ac mauris. Nulla fringilla, justo nec sagittis scelerisque, neque justo tempus tellus, vel suscipit mauris metus vulputate turpis. In vitae neque erat. Sed aliquet rutrum leo, nec blandit enim malesuada quis. Sed suscipit eget felis ac egestas. Integer iaculis nisl rutrum, semper elit eget, volutpat lacus. Ut ut massa mi. Donec efficitur varius convallis. Suspendisse ac tincidunt libero.",
                    image: Image("backflip"),
                    videoURL: nil,
                    comments: [comment],
                    clapCount: 10,
                    creationDate: Date(),
                    startDate: Date(),
                    completionDate: Date())
    }
}

// MARK: - Observable Data Containers
class Stories: ObservableObject {
    @Published var data: [Story]
    
    init(stories: [Story]? = nil) {
        self.data = stories ?? []
    }
}

class PostData: ObservableObject {
    @Published var data: Post
    
    init(post: Post) {
        self.data = post
    }
}
