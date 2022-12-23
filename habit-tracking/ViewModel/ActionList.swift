//
//  ActionList.swift
//  habit-tracking
//
//  Created by Marcus Arkan on 12/20/22.
//

import Foundation

class AddAction: ObservableObject {
    
    @Published var encodeList: [ActionModel] = []

    
    init() {
        encodingUserDefaults()
        decodingUserDefaults()
    }
    
        func encodingUserDefaults() {
            do {
                if let encoder = try? JSONEncoder().encode(encodeList) {
                    UserDefaults.standard.set(encoder, forKey: "ActionType")
                }
            }

        }
    
    
    func decodingUserDefaults() {
        if let data = UserDefaults.standard.data(forKey: "ActionType") {
            if let  decode = try? JSONDecoder().decode([ActionModel].self, from: data) {
                encodeList = decode
            }
        }
    }
    
    
    func delete(index: IndexSet) {
        encodeList.remove(atOffsets: index)
    }
    func move(indexSet: IndexSet, finalSet: Int) {
        encodeList.move(fromOffsets: indexSet, toOffset: finalSet)
    }
}
