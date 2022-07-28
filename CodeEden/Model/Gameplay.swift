//
//  Gameplay.swift
//  CodeEden
//
//  Created by Kathleen Febiola Susanto on 27/07/22.
//

import Foundation

struct chapter: Codable
{
    var id: Int
    var title: String
    var desc: String
    var icon: String
    var levelCount: Int
    var levelDone: Int
}

struct level: Codable
{
    var chapter_id: Int
    var level_id: Int
    var starsCount: Int
    var cleared: Bool
}

struct glossary: Codable
{
    var level_id: Int
    var title: String
    var material: String
    var cover: String
    var isUnlocked: Bool
}

struct tutorial
{
    var illustration: String
    var instruction: String
}

func populateChapter() -> [chapter]
{
    let chapters = [
        
        chapter(id: 1, title: "Introduction", desc: "This chapter will introduce you to basic logic of programming", icon: "Mascot - Cody", levelCount: 4, levelDone: 0),
        chapter(id: 2, title: "Data Structure", desc: "This chapter will let you learn about data structures, their types, and how to implement them", icon: "loupe", levelCount: 6, levelDone: 0)
    ]
    
    return chapters
}

func populateLevel() -> [level]
{
    let levels = [
        
        level(chapter_id: 1, level_id: 1, starsCount: 0, cleared: false),
        level(chapter_id: 1, level_id: 2, starsCount: 0, cleared: false),
        level(chapter_id: 1, level_id: 3, starsCount: 0, cleared: false),
        level(chapter_id: 1, level_id: 4, starsCount: 0, cleared: false),
        level(chapter_id: 2, level_id: 5, starsCount: 0, cleared: false),
        level(chapter_id: 2, level_id: 6, starsCount: 0, cleared: false),
        level(chapter_id: 2, level_id: 7, starsCount: 0, cleared: false),
        level(chapter_id: 2, level_id: 8, starsCount: 0, cleared: false),
        level(chapter_id: 2, level_id: 9, starsCount: 0, cleared: false),
        level(chapter_id: 2, level_id: 10, starsCount: 0, cleared: false)
    ]
    
    return levels
}


func populateGlossaries() -> [glossary]
{
    let glossaries = [
        
        glossary(level_id: 1, title: "What is an Algorithm?", material: """
                An algorithm is a procedure used for solving a problem or performing a computation. Algorithms act as an exact list of instructions that conduct specified actions step by step. In computer programming terms, an algorithm is a set of well-defined instructions to solve a particular problem. It takes a set of input(s) and produces the desired output. For example, an algorithm to add two numbers would be:

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
        """, cover: "Intro Cover", isUnlocked: false),
        glossary(level_id: 2, title: "Searching Algorithm", material: """
                Searching algorithms refers to algorithms used to search or find one or more than on element from a certain dataset. It's an algorithm that allows you to find your favorite book from the stacks of books in the cupboard. There are several type of searching algorithm, but let's look at simple explanation to the two most common: Linear and Binary Search
                        
                1. Linear Search
                        
                Linear search starts from one side of the dataset and compare the data one by one until it found the searched item. It works as such
                        
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
        """, cover: "Intro Cover", isUnlocked: false),
        glossary(level_id: 3, title: "Pathfinding Algorithm", material: """
                Pathfinding algorithms address the problem of finding a path from a source to a destination avoiding obstacles and minimizing the costs (time, distance, risks, fuel, price, etc.). Example of such problem is how to find the closest way to go from your house to your office/school. Here is an example on how the algorithm works by putting a cost in each step it takes:
                        
                1. Start on the goal square. How far is the goal from the goal? Zero steps, mark the goal with the number 0.
                2. Find all squares in the maze that are exactly one step away from the goal. Mark them with the number 1. In this maze, if the goal is the exit square, then there is only one square that is exactly one step away.
                3. Now find all squares in the maze that are exactly two steps away from the goal. These squares are one step away from those marked 1 and have not yet been marked. Mark these squares with the number 2.
                4. Mark all squares in the maze that are exactly three steps away from the goal. These squares are one step away from those marked 2 and have not yet been marked. Mark these squares with the number 3.
                5. Keep marking squares in the maze in order of increasing distance from the goal.
                        
                Now, how can we implement this algorithm in the next challenge?
                        
                Reference:
                https://medium.com/@urna.hybesis/pathfinding-algorithms-the-four-pillars-1ebad85d4c6b
                https://www.khanacademy.org/computing/computer-science/algorithms/intro-to-algorithms/a/route-finding
        
        """, cover: "Data Structures in Swift", isUnlocked: false),
        glossary(level_id: 4, title: "Intro to Data Structure", material: """
                Data structure is a storage that is used to store and organize data. It is a way of arranging data
                on a computer so that it can be accessed and updated efficiently. Once again, the data structure is
                not a programming language, but rather a set of algorithms that we can use in any programming
                language to structure the data in the memory. These set of algorithms can also be said to be set of
                rules in a way to structure the data.
                        
                For example, you want to arrange a data structure of the students in your school ordered based on
                their student ID. Using the common data structure array, you will then put such rule:
                        
                "If student A's student ID is lower than student B's then it should be placed in an index in front
                of student B, other wise put in on an index next to student B"
                        
                There are several types of data structures out there, from the Linear Data Structures  to Non-linear
                Data Structures. We'll discuss on some of these data structures later in the next challenges!
                        
                        
                Reference:
                        
                https://www.programiz.com/dsa/data-structure-types
                https://www.javatpoint.com/data-structure-tutorial
            """, cover: "Data Structure Cover", isUnlocked: false),
        glossary(level_id: 5, title: "Data Structures in Swift", material: """
                    
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
                    
                var studentID: Set = [21, 32, 43, 57]
                    
                A set is a collection of unique data. That is, elements of a set cannot be duplicate. You can use
                sets instead of arrays if ordering of elements is not an issue, or if you want to ensure that there
                are no duplicate values. There are several action you can do with Swift's set like union,
                intersection, and substracting.
                    
                Choosing the right Data Structure to use will affect a lot of things in your program. Let's see
                how well you understand the difference between each data structure in the next challenge!
                    
                Reference:
                    
                https://www.swiftbysundell.com/articles/picking-the-right-data-structure-in-swift/
                https://www.tutorialspoint.com/swift/swift_dictionaries.htm
                https://www.tutorialspoint.com/swift/swift_sets.htm
            """, cover: "Data Structure Cover", isUnlocked: false),
        glossary(level_id: 7, title: "Stacks and Queue", material: """
                Stacks and Queue are another type of linear data structure. Let's take a look at their differences!
                    
                Stacks
                    
                A stack is a linear data structure in which elements can be inserted and deleted only from one side
                of the list, called the top. A stack follows the LIFO (Last In First Out) principle, i.e., the
                element inserted at the last is the first element to come out. It's like stacking books, where if
                you want to take some book out you will need to start from the top and not the bottom.
                    
                Queue
                    
                Queue is a linear data structure in which elements can be inserted only from one side of the list
                called rear, and the elements can be deleted only from the other side called the front. The queue
                data structure follows the FIFO (First In First Out) principle, i.e. the element inserted at first
                in the list, is the first element to be removed from the list. It works just like a queue in real
                life where someone will get in from the rear and get out once they reached the front.
                    
                Now that you have read about stacks and queue, let's see the implementation on the next challenges!
            
                Reference:
                https://www.geeksforgeeks.org/difference-between-stack-and-queue-data-structures/
            
            """, cover: "Data Structure Cover", isUnlocked: false)
    ]
    
    return glossaries
}

extension Array: RawRepresentable where Element: Codable {
    public init?(rawValue: String) {
        guard let data = rawValue.data(using: .utf8) else {
            return nil
        }
        do {
            let result = try JSONDecoder().decode([Element].self, from: data)
            print("Init from result: \(result)")
            self = result
        } catch {
            print("Error: \(error)")
            return nil
        }
    }

    public var rawValue: String {
        guard let data = try? JSONEncoder().encode(self),
              let result = String(data: data, encoding: .utf8)
        else {
            return "[]"
        }
        print("Returning \(result)")
        return result
    }
}
