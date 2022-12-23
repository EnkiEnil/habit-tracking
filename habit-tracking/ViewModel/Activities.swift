import Foundation
import SwiftUI

class Activities: ObservableObject {
    @Published var action = [Habits]() {
        didSet {
            if let encoder = try? JSONEncoder().encode(action) {
                UserDefaults.standard.set(encoder, forKey: "Activities")
            }
        }
    }
    
    
    init() {
        habitViewModel()
    }
    
    func habitViewModel() {
        if let userData = UserDefaults.standard.data(forKey: "Activities") {
            if let decoded = try? JSONDecoder().decode([Habits].self, from: userData) {
                action = decoded
            }
        }
    }
    
    func updateHabitCompletionStatus(id: UUID, completionStatus: Bool) {
        if let index = action.firstIndex(where: { $0.id == id }) {
            action[index].completionStatus = completionStatus
        }
    }

    
    func onDelete(at index: IndexSet) {
        action.remove(atOffsets: index)
    }
    
    func onMove(start: IndexSet, finish: Int) {
        action.move(fromOffsets: start, toOffset: finish)
    }

}
