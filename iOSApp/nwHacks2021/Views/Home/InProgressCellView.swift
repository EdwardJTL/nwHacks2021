//
//  InProgressCellView.swift
//  nwHacks2021
//
//  Created by Edward Luo on 2021-01-09.
//

import Foundation
import SwiftUI

struct InProgressCellView: View {
    let skillInProgress: InProgressSkill
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            Group {
                if let safeImage = skillInProgress.skill.image {
                    safeImage
                        .resizable()
                } else {
                    Image("backflip")
                        .resizable()
                }
            }
            .aspectRatio(1, contentMode: .fill)
            LinearGradient(gradient: Gradient(colors: [.clear, Color.black.opacity(0.5)]), startPoint: .top, endPoint: .bottom)
            VStack(alignment: .leading) {
                Text(skillInProgress.skill.title)
                    .foregroundColor(.white)
                    .bold()
                Text(toDateString(from: skillInProgress.startedAt))
                    .foregroundColor(.white)
            }
            .padding()
        }
        .aspectRatio(1, contentMode: .fit)
        .cornerRadius(10.0, antialiased: true)
    }
}

struct InProgressCellView_Previews: PreviewProvider {
    static var previews: some View {
        InProgressCellView(skillInProgress: InProgressSkill(skill: Skill(title: "Backflip", body: [], categories: []), startedAt: Date()))
    }
}
