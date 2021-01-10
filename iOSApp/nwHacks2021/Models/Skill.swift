//
//  Skill.swift
//  nwHacks2021
//
//  Created by Edward Luo on 2021-01-09.
//

import Foundation
import SwiftUI

struct Skill {
    let title: String
    let body: [SkillBody]
    let categories: [String]
}

struct SkillBody {
    let description: String
    let image: Image?
    let videoURL: String?
}

struct SkillInProgress {
    let skill: Skill
    let startedAt: Date
    var completed = false
}
