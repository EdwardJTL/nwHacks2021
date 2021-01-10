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
    let body: [SkillBody]
    let categories: [String]
    let completedCount: Int?
    let estimatedTime: TimeInterval?
    let description: String?
    let image: Image?
    let videoURL: String?
    
    init(title: String,
         body: [SkillBody],
         categories: [String],
         completedCount: Int? = nil,
         estimatedTime: TimeInterval? = nil,
         description: String? = nil,
         image: Image? = nil,
         videoURL: String? = nil) {
        self.title = title
        self.body = body
        self.categories = categories
        self.completedCount = completedCount
        self.estimatedTime = estimatedTime
        self.description = description
        self.image = image
        self.videoURL = videoURL
    }
}

struct SkillBody {
    let description: String
    let image: Image?
    let videoURL: String?
}

struct InProgressSkill {
    let skill: Skill
    let startedAt: Date
    var completed = false
}

// MARK: - Preview Data Generator
struct PreviewInProgressSkills {
    var data: [InProgressSkill]
    
    init() {
        data = []
        for _ in 0..<10 {
            data.append(InProgressSkill(skill: Skill(title: "Backflip", body: [], categories: []), startedAt: Date()))
        }
    }
}

struct PreviewDiscoverSkills {
    var data: [Skill]
    
    init() {
        data = []
        for _ in 0..<10 {
            data.append(Skill(title: "Knitting", body: [], categories: ["Home"], completedCount: 10, estimatedTime: TimeInterval(180), description: "Learn to knit a beanie in 3 easy steps!", image: Image("knitting"), videoURL: nil))
        }
    }
}

struct PreviewExploreableSkills {
    var data: [Skill]
    
    init() {
        data = []
        for _ in 0..<10 {
            data.append(Skill(title: "Knitting", body: [], categories: ["Home"], completedCount: 10, estimatedTime: TimeInterval(180), description: "Learn to knit a beanie in 3 easy steps!", image: Image("knitting"), videoURL: nil))
        }
        for _ in 0..<10 {
            data.append(Skill(title: "Knitting", body: [], categories: ["Health"], completedCount: 10, estimatedTime: TimeInterval(180), description: "Learn to knit a beanie in 3 easy steps!", image: Image("knitting"), videoURL: nil))
        }
        for _ in 0..<10 {
            data.append(Skill(title: "Knitting", body: [], categories: ["Cooking"], completedCount: 10, estimatedTime: TimeInterval(180), description: "Learn to knit a beanie in 3 easy steps!", image: Image("knitting"), videoURL: nil))
        }
        for _ in 0..<10 {
            data.append(Skill(title: "Knitting", body: [], categories: ["Art"], completedCount: 10, estimatedTime: TimeInterval(180), description: "Learn to knit a beanie in 3 easy steps!", image: Image("knitting"), videoURL: nil))
        }
        for _ in 0..<9 {
            data.append(Skill(title: "Knitting", body: [], categories: ["Coding"], completedCount: 10, estimatedTime: TimeInterval(180), description: "Learn to knit a beanie in 3 easy steps!", image: Image("backflip"), videoURL: nil))
        }
    }
}

struct PreviewExploreableCategories {
    var data: [String]
    
    init() {
        data = ["Home", "Health", "Cooking", "Art", "Coding"]
    }
}

struct PreviewTrendingSkills {
    var data: [Skill]
    
    init() {
        data = []
        for i in 0..<10 {
            data.append(Skill(title: "Backflip", body: [], categories: [], completedCount: 1003 - i*17))
        }
    }
}


// MARK: - Observable Data Containers
class InProgressSkills: ObservableObject {
    @Published var skills: [InProgressSkill]
    
    init() {
        skills = []
    }
    
    init(skills: [InProgressSkill]) {
        self.skills = skills
    }
}

class DiscoverSkills: ObservableObject {
    @Published var skills: [Skill]
    
    init() {
        skills = []
    }
    
    init(skills: [Skill]) {
        self.skills = skills
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
