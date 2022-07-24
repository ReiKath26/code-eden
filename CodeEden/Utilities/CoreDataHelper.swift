//
//  CoreDataHelper.swift
//  CodeEden
//
//  Created by Kathleen Febiola Susanto on 24/07/22.
//

import Foundation
import CoreData
import SwiftUI

class DataMockStore: ObservableObject
{
    let container = NSPersistentContainer(name: "CodeEden")
    
    init()
    {
        container.loadPersistentStores { desc, error in
            if let error = error
            {
                print("Failed to load data: \(error.localizedDescription)")
            }
        }
    }
    
    func save(context: NSManagedObjectContext)
    {
        do
        {
            try context.save()
            
        }
        
        catch
        {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    
    func newPlayer(name:String, avatar: String, context: NSManagedObjectContext) -> Player
    {
        let player = Player(context: context)
        player.name = name
        player.avatar = avatar
        player.hint = 0
        player.stars = 0
        player.timestamp = Date()
        
        save(context: context)
        
        return player
    }
    
    func editProfile(player: Player, name:String, avatar: String, context: NSManagedObjectContext)
    {
        player.name = name
        player.avatar = avatar
        
        save(context: context)
    }
    
    func addHint(player: Player, hint: Int, context: NSManagedObjectContext)
    {
        player.hint += Double(hint)
        
        save(context: context)
    }
    
    func useHint(player: Player, hint: Int, context: NSManagedObjectContext)
    {
        player.hint -= Double(hint)
        
        save(context: context)
    }
    
    func addStars(player: Player, stars: Int, context: NSManagedObjectContext)
    {
        player.stars += Double(stars)
        
        save(context: context)
    }
    
    func gamePlayMockStore(context: NSManagedObjectContext) -> [Chapter]
    {
        var mockStore: [Chapter] = []
        
        let chapter1 = Chapter(context: context)
        chapter1.title = "Intro to DSA"
        chapter1.icon = "Mascot - Cody"
        chapter1.progress = 0
        
        let chapter2 = Chapter(context: context)
        chapter2.title = "Stack & Queue"
        chapter2.icon = "loupe"
        chapter2.progress = 0
        
        
        for _ in (0..<4)
        {
            var x: Double = 1
            
            let levelNormal1 = Level(context: context)
            levelNormal1.isDone = false
            levelNormal1.id = 110 + x
            levelNormal1.stars = 0
            levelNormal1.mode = "Normal"
            chapter1.addToLevel(levelNormal1)
            
            let levelHard = Level(context: context)
            levelHard.isDone = false
            levelHard.id = 210 + x
            levelHard.stars = 0
            levelHard.mode = "Hard"
            chapter1.addToLevel(levelHard)
            
            x+=1
        }
        
        
        for _ in (0..<4)
        {
            var x: Double = 1
            
            let levelNormal1 = Level(context: context)
            levelNormal1.isDone = false
            levelNormal1.id = 120 + x
            levelNormal1.stars = 0
            levelNormal1.mode = "Normal"
            chapter2.addToLevel(levelNormal1)
            
            let levelHard = Level(context: context)
            levelHard.isDone = false
            levelHard.id = 220 + x
            levelHard.stars = 0
            levelHard.mode = "Hard"
            chapter2.addToLevel(levelHard)
            
            x+=1
        }
       
        //MARK: add glossaries
        
        mockStore.append(chapter1)
        mockStore.append(chapter2)
        
        
        return mockStore
    }
    
    func achievementMockStore(context: NSManagedObjectContext) -> [Achievement]
    {
        var mockstore: [Achievement] = []
        
        let achievement = Achievement(context: context)
        achievement.progress = 0
        achievement.desc = "Collect 10 Stars"
        achievement.icon = "star"
        
        let anotherAchievement = Achievement(context: context)
        achievement.progress = 0
        achievement.desc = "Complete 5 levels without using hints"
        achievement.icon = "loupe"
        
        mockstore.append(achievement)
        mockstore.append(anotherAchievement)
        
        save(context: context)
        
        return mockstore
    }
    
    func updateAchievementProgress(player: Player, achievement: Achievement, progress: Float, context: NSManagedObjectContext)
    {
        achievement.progress = progress
        
        if achievement.progress == 1
        {
            player.addToAchievement(achievement)
        }
        
        save(context: context)
    }
}

