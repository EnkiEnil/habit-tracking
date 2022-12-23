//
//  Habits.swift
//  habit-tracking
//
//  Created by Marcus Arkan on 10/26/22.
//


import Foundation


struct Habits: Hashable, Codable, Equatable {
    var id = UUID()
    var activity: String
    var dueDate: Date
    var startDate: Date
    var description: String
    var completionStatus: Bool
}
