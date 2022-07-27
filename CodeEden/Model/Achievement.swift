//
//  Achievement.swift
//  CodeEden
//
//  Created by Kathleen Febiola Susanto on 27/07/22.
//

import Foundation


struct achievement: Codable 
{
    var title: String
    var count: Int
    var icon: String
    var need: Int
    var isAchieved: Bool
}

func populateAchievement() -> [achievement]
{
    let achievements: [achievement] = [
        
        achievement(title: "Collect 10 Stars", count: 0, icon: "star", need: 10, isAchieved: false),
        achievement(title: "Complete 5 level without using hint", count: 0, icon: "loupe", need: 5, isAchieved: false)
    ]
    
    return achievements
}
