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
        chapter1.title = "Introduction"
        chapter1.icon = "Mascot - Cody"
        chapter1.progress = 0
        
        let chapter2 = Chapter(context: context)
        chapter2.title = "Data Structure I"
        chapter2.icon = "loupe"
        chapter2.progress = 0
        
        
        for _ in (0..<4)
        {
            var x: Double = 1
            
            let levelNormal1 = Level(context: context)
            levelNormal1.isDone = false
            levelNormal1.levelID = 110 + x
            levelNormal1.stars = 0
            levelNormal1.mode = "Normal"
            chapter1.addToLevel(levelNormal1)
            
            x+=1
        }
        
        
        for _ in (0..<7)
        {
            var x: Double = 1
            
            let levelNormal1 = Level(context: context)
            levelNormal1.isDone = false
            levelNormal1.levelID = 120 + x
            levelNormal1.stars = 0
            levelNormal1.mode = "Normal"
            chapter2.addToLevel(levelNormal1)
            
            x+=1
        }
       
        //MARK: add glossaries
        
        mockStore.append(chapter1)
        mockStore.append(chapter2)
        
        save(context: context)
        
        return mockStore
    }
    
    func glossariesMockStore(levels: [Level], context:NSManagedObjectContext) -> [Glossary]
    {
        var mockStore: [Glossary] = []
        
        let gl_1 = Glossary(context: context)
        gl_1.title = "What is an Algorithm?"
        gl_1.isUnlocked = false
        gl_1.material = """
        An algorithm is a procedure used for solving a problem or performing a computation.
        Algorithms act as an exact list of instructions that conduct specified actions step by step.
        In computer programming terms, an algorithm is a set of well-defined instructions to
        solve a particular problem. It takes a set of input(s) and produces the desired output.
        For example, an algorithm to add two numbers would be:

        Take two number inputs

        Add numbers using the + operator

        Display the result
        
        So, what makes a good algorithm?
        
        1. To make a good algorithm, you need a clear input and output and clear steps on how to proceed with said algorithm
        2. Algorithm is not the same as computer code.
        3. Algorithm should be written in such a way that it can be used in different programming languages
        4. Algorithm should terminate after a finite time
                
        Next time, we'll explore more on some examples of algorithms, so catch you later!
        
        Reference:
        
        https://www.techtarget.com/whatis/definition/algorithm
        https://www.programiz.com/dsa/algorithm
        https://www.geeksforgeeks.org/introduction-to-algorithms/
        
        """
        
        let gl_2 = Glossary(context: context)
        gl_2.title = "Searching Algorithm"
        gl_2.isUnlocked = false
        gl_2.material = """
        
        Searching algorithms refers to algorithms used to search or find one or more than one element from a
        certain dataset. It's an algorithm that allows you to find your favorite book from the stacks of
        books in the cupboard. There are several type of searching algorithm, but let's look at simple
        explanation to the two most common: Linear and Binary Search
        
        1. Linear Search
        
        Linear search starts from one side of the dataset and compare the data one by one until it found
        the searched item. It works as such
        
        - Start from the leftmost element
        - If the item matches the searched item, return it's position
        - If the item doesn't match, return continue searching
        - If no item match, return -1 as it's not found
        
        2. Binary Search
        
        Binary search works as such:
        
        - Begin in the mid element of the dataset
        - If the item matches the searched item, return it's position
        - If the item is less than the searched item, narrow search interval to the lower half
        - If the item is more than the searched item, narrow search interval to upper half
        - Repeat the steps until item is found or if the item is not found anywhere
        
        
        See the difference? Let's see how you implement this algorithm on your next challenge!
        
        Reference:
        
        https://www.tutorialspoint.com/introduction-to-searching-algorithms
        https://www.geeksforgeeks.org/linear-search/
        https://www.geeksforgeeks.org/binary-search/
        
        """
        
        let gl_3 = Glossary(context: context)
        gl_3.title = "Pathfinding Algorithm"
        gl_3.isUnlocked = false
        gl_3.material = """
        
        Pathfinding algorithms address the problem of finding a path from a source to a destination avoiding
        obstacles and minimizing the costs (time, distance, risks, fuel, price, etc.). Example of such
        problem is how to find the closest way to go from your house to your office/school. Here is an
        example on how the algorithm works by putting a cost in each step it takes:
        
        1. Start on the goal square. How far is the goal from the goal? Zero steps, mark the goal with the number 0.
        2. Find all squares in the maze that are exactly one step away from the goal. Mark them with the number 1. In this maze, if the goal is the exit square, then there is only one square that is exactly one step away.
        3. Now find all squares in the maze that are exactly two steps away from the goal. These squares are one step away from those marked 1 and have not yet been marked. Mark these squares with the number 2.
        4. Mark all squares in the maze that are exactly three steps away from the goal. These squares are one step away from those marked 2 and have not yet been marked. Mark these squares with the number 3.
        5. Keep marking squares in the maze in order of increasing distance from the goal.
        
        Now, how can we implement this algorithm in the next challenge?
        
        Reference:
        https://medium.com/@urna.hybesis/pathfinding-algorithms-the-four-pillars-1ebad85d4c6b
        https://www.khanacademy.org/computing/computer-science/algorithms/intro-to-algorithms/a/route-finding
        
        """
        
        let gl_4 = Glossary(context: context)
        gl_4.title = "Intro to Data Structure"
        gl_4.isUnlocked = false
        gl_4.material = """
        
        
        
        """
        
        let gl_5 = Glossary(context: context)
        gl_5.title = "Data Structure in Swift"
        gl_5.isUnlocked = false
        gl_5.material = """
        
        The Swift standard library ships with three main data structures — Array, Dictionary and Set — that
        each comes with a different set of optimizations, pros and cons.
        
        1. Array
        
        var shapes: [Circle, Triangle, Square]
        
        Array keeps its elements in sequence, it’s easy to iterate through in a predictable fashion, and it
        can store any kind of value — from structs, to class instances, to other collections. Not only do
        arrays store their elements in a very efficient manner, they also have a guaranteed order of
        iteration, which gives us a predictable drawing order without having to do any extra work.
        
        However, we’ll start encountering one such downside when we want to start removing shapes from our
        canvas. Since array elements are stored by index, we will always need to look up which index that a
        given shape is associated with before we can remove it.
        
        2. Dictionary
        
        var someDictionary: [Int: String] = [1: "One", 2: "Two", 3: "Three")
        
        Dictionaries are used to store unordered lists of values of the same type. Dictionaries use unique
        identifier known as a key to store a value which later can be referenced and looked up through the
        same key. Unlike items in an array, items in a dictionary do not have a specified order. You can use
        a dictionary when you need to look up values based on their identifiers.
        
        3. Set
        
        Reference:
        
        https://www.swiftbysundell.com/articles/picking-the-right-data-structure-in-swift/
        https://www.tutorialspoint.com/swift/swift_dictionaries.htm
        
        """
        
        let gl_6 = Glossary(context: context)
        gl_6.title = "Stacks & Queue"
        gl_6.isUnlocked = false
        gl_6.material = """
        
        
        
        """
        
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

