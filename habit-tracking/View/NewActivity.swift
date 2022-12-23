//
//  NewActivity.swift
//  habit-tracking
//
//  Created by Marcus Arkan on 12/20/22.
//

import SwiftUI

struct NewActivity: View {

    //MARK: Environment
    @Environment(\.dismiss) var dismiss
    
    //MARK: UserDefault Database
    @ObservedObject var addAction: AddAction
    
    //MARK: PROPERTIES
    @State var newHabits: String = ""
    let buttonBackground = Color(#colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1))

    var body: some View {
        
        NavigationStack {
            List {
                TextField(text: $newHabits) {
                    Text("Enter New Field...")
                }
                
                ForEach(addAction.encodeList) {
                        value in Text(value.typeOfAction)
                }
                .onDelete(perform: addAction.delete)
                .onMove(perform: addAction.move)
            }.toolbar{
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Exit"){ dismiss()}
                }
            }
            Button(action: {
               let model = ActionModel(typeOfAction: newHabits)
                addAction.encodeList.append(model)
                newHabits = ""
            }, label: {
                
                Text("Submit")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(buttonBackground)
                    .cornerRadius(40)
                    .padding()
                    .shadow(color: .black, radius: 12, x: 2, y: 10)
                
            })
        }
    }
}

struct NewActivity_Previews: PreviewProvider {

    static var previews: some View {

        NewActivity(addAction: AddAction())
    }
}

