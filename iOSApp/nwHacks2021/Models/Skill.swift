//
//  Skill.swift
//  nwHacks2021
//
//  Created by Edward Luo on 2021-01-09.
//

import Combine
import Foundation
import SwiftUI

// MARK: - Data types
struct Skill {
    let title: String
    let categories: [String]
    let completedCount: Int?
    let estimatedTime: TimeInterval?
    let creator: User
    let description: String
    let image: Image?
    let videoURL: String?
    
    init(title: String,
         categories: [String],
         completedCount: Int? = nil,
         estimatedTime: TimeInterval? = nil,
         creator: User,
         description: String,
         image: Image? = nil,
         videoURL: String? = nil) {
        self.title = title
        self.categories = categories
        self.completedCount = completedCount
        self.estimatedTime = estimatedTime
        self.creator = creator
        self.description = description
        self.image = image
        self.videoURL = videoURL
    }
}

struct InProgressSkill {
    let skill: Skill
    let startedAt: Date
    var completed = false
}

// MARK: - Preview Data Generator
struct BackFlipSkill {
    var data: Skill
    
    init() {
        data = Skill(title: "Backflip", categories: ["Sports"], completedCount: 10, estimatedTime: 3600, creator: User.defaultUser(), description: "Here is how you do a backflip", image: Image("backflip"), videoURL: nil)
    }
}

struct DemoPoachEggSkill {
    var data: Skill
    
    init() {
        data = Skill(title: "Poach an Egg", categories: ["cooking"], completedCount: 150, estimatedTime: 120,
                     creator: User.DemoUsers(id: 0),
                     description: "Poach an perfect egg in 3 easy steps!", image: Image("poached-egg"), videoURL: nil)
    }
}

struct PreviewInProgressSkills {
    var data: [InProgressSkill]
    
    init() {
        data = []
        for _ in 0..<10 {
            data.append(InProgressSkill(skill: BackFlipSkill().data, startedAt: Date()))
        }
    }
}

struct PreviewDiscoverSkills {
    var data: [Skill]
    
    init() {
        data = []
        for _ in 0..<10 {
            data.append(Skill(title: "Knitting", categories: ["home"], completedCount: 10, estimatedTime: TimeInterval(180), creator: User.defaultUser(), description: "Learn to knit a beanie in 3 easy steps!", image: Image("knitting"), videoURL: nil))
        }
    }
}

struct PreviewExploreableSkills {
    var data: [Skill]
    
    init() {
        data = []
        for _ in 0..<10 {
            data.append(Skill(title: "Knitting", categories: ["Home"], completedCount: 10, estimatedTime: TimeInterval(18000), creator: User.defaultUser(), description: "Learn to knit a beanie in 3 easy steps!", image: Image("knitting"), videoURL: nil))
        }
        for _ in 0..<10 {
            data.append(Skill(title: "Backflip", categories: ["Fitness"], completedCount: 50, estimatedTime: TimeInterval(3000), creator: User.DemoUsers(id: 3), description: "Backflip like you're spooderman", image: Image("backflip"), videoURL: nil))
        }
        for _ in 0..<10 {
            data.append(Skill(title: "Poached Eggs", categories: ["Cooking"], completedCount: 150, estimatedTime: TimeInterval(180), creator: User.DemoUsers(id: 0), description: "Each poached eggs", image: Image("poached-egg"), videoURL: nil))
        }
        for _ in 0..<10 {
            data.append(Skill(title: "Caligraphy", categories: ["Art"], completedCount: 5, estimatedTime: TimeInterval(6000), creator: User.DemoUsers(id: 4), description: "Write pretty letters for your loved ones!", image: Image("calli"), videoURL: nil))
        }
    }
}

struct PreviewExploreableCategories {
    var data: [String]
    
    init() {
        data = ["Home", "Fitness", "Cooking", "Art"]
    }
}

struct PreviewTrendingSkills {
    var data: [Skill]
    
    init() {
        data = []
        for i in 0..<10 {
            data.append(Skill(title: "Backflip", categories: [], completedCount: 1003 - i*17, creator: User.defaultUser(), description: "This is trending"))
        }
    }
}


// MARK: - Observable Data Containers
class InProgressSkills: ObservableObject {
    @Published var skills: [InProgressSkill]
    
    init(skills: [InProgressSkill]? = nil) {
        self.skills = skills ?? []
    }
}

class DiscoverSkills: ObservableObject {
    @Published var skills: [Skill]
    
    init(skills: [Skill]? = nil) {
        self.skills = skills ?? []
    }
}

class ExploreableSkills: ObservableObject {
    @Published var skills: [Skill]
    
    init() {
        skills = []
    }
    
    init(skills: [Skill]) {
        self.skills = skills
    }
    
}

class ExploreableCategories: ObservableObject {
    @Published var categories: [String]
    
    init() {
        categories = []
    }
    
    init(categories: [String]) {
        self.categories = categories
    }
}

class TrendingSkills: ObservableObject {
    @Published var skills: [Skill]
    
    init() {
        skills =  []
    }
    
    init(skills: [Skill]) {
        self.skills = skills
    }
}
