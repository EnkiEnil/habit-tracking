//
//  ActionModel.swift
//  habit-tracking
//
//  Created by Marcus Arkan on 12/20/22.
//

import Foundation


struct ActionModel: Identifiable, Codable, Equatable {
    var id = UUID()
    var typeOfAction: String
}
