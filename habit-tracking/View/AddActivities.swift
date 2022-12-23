//
//  AddActivities.swift
//  habit-tracking
//
//  Created by Marcus Arkan on 10/26/22.
//

import SwiftUI

struct AddActivities: View {
    
    //ObservedObjects
    @ObservedObject var action: Activities
    @ObservedObject var addMoreActivities: AddAction
    
    //State environment properties
    @Environment(\.dismiss) var dismiss
    @State var dueDate = Date()
    @State var startDate = Date.now
    @State var selection = "Nothing selected"
    @State var description = ""
    @State var isCompleted: Bool = false
    @State var showSheet: Bool = false
    @State var activityType: [String] = []
    @State var addedList:[String] = []
    
    //Properties
    let buttonBackground = Color(#colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1))
    
    //Enums
    enum alertTypes {
        case success, error
    }
    
    var dateSelection: DateFormatter {
        let date = DateFormatter()
        date.timeZone = .current
        date.dateStyle = .medium
        date.timeStyle = .medium
        return date
    }
    
    var body: some View {
        
        NavigationStack {
            Form {
                TextField("Description", text: $description)
                DatePicker("Start Date", selection: $startDate)
                DatePicker("Due Date", selection: $dueDate)
                Toggle("Completion", isOn: $isCompleted)
                Picker("Select or Add", selection: $selection) {
                    ForEach(activityType, id: \.self) {
                        value in
                        Text(value)
                    }

                }
                .pickerStyle(.inline)
                .onReceive([addMoreActivities].publisher) { _ in
                   activityType = addMoreActivities.encodeList.map { $0.typeOfAction }
                }
                
            }
            
            .toolbar {
                Button("Add") {showSheet.toggle() }
            }
            .sheet(isPresented: $showSheet) {
                NewActivity(addAction: addMoreActivities).presentationDetents([.fraction(0.85), .medium, .large])
            }
            Button("Save", action: save)
                .frame(width: 100, height: 50)
                .background(buttonBackground).foregroundColor(.white)
                .cornerRadius(20)
                .shadow(color: .gray, radius: 12, x:12, y: 3)
            //    .offset(CGSize(width:0, height: -150))
        }
    }
    
    func save() {
        let items = Habits(activity: selection, dueDate: dueDate, startDate: startDate, description: description, completionStatus: isCompleted)
        
        action.action.append(items)
        dismiss()
    }
}

struct AddActivities_Previews: PreviewProvider {
    
    static var previews: some View {
        AddActivities(action: Activities(), addMoreActivities: AddAction())
    }
}
