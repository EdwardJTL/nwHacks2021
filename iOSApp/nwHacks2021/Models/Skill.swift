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
    let description: String
    let image: Image?
    let videoURL: String?
    
    init(title: String,
         categories: [String],
         completedCount: Int? = nil,
         estimatedTime: TimeInterval? = nil,
         description: String,
         image: Image? = nil,
         videoURL: String? = nil) {
        self.title = title
        self.categories = categories
        self.completedCount = completedCount
        self.estimatedTime = estimatedTime
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
struct PreviewSkill {
    var data: Skill
    
    init() {
        data = Skill(title: "Backflip", categories: ["Sports"], completedCount: 10, estimatedTime: 3600, description: "Here is how you do a backflip", image: Image("backflip"), videoURL: nil)
    }
}

struct PreviewInProgressSkills {
    var data: [InProgressSkill]
    
    init() {
        data = []
        for _ in 0..<10 {
            data.append(InProgressSkill(skill: PreviewSkill().data, startedAt: Date()))
        }
    }
}

struct PreviewDiscoverSkills {
    var data: [Skill]
    
    init() {
        data = []
        for _ in 0..<10 {
            data.append(Skill(title: "Knitting", categories: ["home"], completedCount: 10, estimatedTime: TimeInterval(180), description: "Learn to knit a beanie in 3 easy steps!", image: Image("knitting"), videoURL: nil))
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
