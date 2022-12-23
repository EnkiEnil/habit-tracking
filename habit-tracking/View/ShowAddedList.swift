//
//  ShowAddedList.swift
//  habit-tracking
//
//  Created by Marcus Arkan on 11/19/22.
//

import SwiftUI

struct ShowAddedList: View {
    
    @StateObject var habits = Activities()
    let dueDateColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
    let buttonBackground = Color(#colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1))
    var body: some View {
        
        NavigationView {
            List {
                ForEach(habits.action, id: \.self) {
                    value in
                    VStack(alignment: .leading, spacing: 20) {
                        
                        NavigationLink(destination: Text(value.description).font(.largeTitle)) {
                            if #available(iOS 16.1, *) {
                                Text(value.activity).font(.title2.bold()).fontDesign(.rounded)
                            } else {
                                // Fallback on earlier versions
                                Text(value.activity).font(.title2.bold())
                            }
                        }
                        
                        
                        Text("Due Date: \(value.dueDate, format: .dateTime)").font(.headline).foregroundColor(value.completionStatus ? .green:Color(dueDateColor))
                            Text("Start Date: \(value.startDate, format: .dateTime)")
                            
                        HStack {
                            Text("Completion Status:")
                            
                            Text("\(getStatus(for: value.completionStatus))").foregroundColor(.white)
                                .frame(height: 35)
                                .frame(maxWidth: .infinity)
                                .background(value.completionStatus ? buttonBackground:.pink)
                                .cornerRadius(3)
                                .onTapGesture {
                                    habits.updateHabitCompletionStatus(id: value.id, completionStatus:value.completionStatus == false ? true:false)
                            }
                        }
                 
                    }
                }
                .onDelete(perform: habits.onDelete)
                .onMove(perform: habits.onMove)
            }
            .toolbar {
                EditButton()
        }
        }
    }
    
    func getStatus(for status: Bool) -> String {
        var statusCode = String()
        if status {
            statusCode = "Done"
        } else {
            statusCode = "Pending"
        }
        return statusCode
    }
}

struct ShowAddedList_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ShowAddedList(habits: Activities())
        }
    }
}
