//
//  Skill.swift
//  nwHacks2021
//
//  Created by Edward Luo on 2021-01-09.
//

import Combine
import Foundation
import SwiftUI

struct Skill {
    let title: String
    let body: [SkillBody]
    let categories: [String]
    let completedCount: Int?
    let estimatedTime: TimeInterval?
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

class InProgressSkills: ObservableObject {
    @Published var skills: [InProgressSkill]
    
    init() {
        skills = []
    }
    
    init(skills: [InProgressSkill]) {
        self.skills = skills
    }
}
