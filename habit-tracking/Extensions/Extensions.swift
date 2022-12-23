//
//  Extensions.swift
//  habit-tracking
//
//  Created by Marcus Arkan on 10/26/22.
//

import Foundation

//Store Nested Arrays in @AppStorage for SwiftUI - All you need is to conform Array to RawRepresentable using the extension below.

extension Array: RawRepresentable where Element: Codable {
    public init?(rawValue: String) {
        guard let data = rawValue.data(using: .utf8),
              let result = try? JSONDecoder().decode([Element].self, from: data)
        else {
            return nil
        }
        self = result
    }

    public var rawValue: String {
        guard let data = try? JSONEncoder().encode(self),
              let result = String(data: data, encoding: .utf8)
        else {
            return "[]"
        }
        return result
    }
}
