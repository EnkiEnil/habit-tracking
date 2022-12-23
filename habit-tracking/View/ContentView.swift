//
//  ContentView.swift
//  habit-tracking
//
//  Created by Marcus Arkan on 10/24/22.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var userSelection = Activities()
    @StateObject var addAction = AddAction()
    @State var isShowing: Bool = false
        
    var body: some View {
        NavigationStack {
            VStack {
              ShowAddedList(habits: userSelection)

                        Button {
                            isShowing.toggle()
                        } label: {
                            HStack {
                                Text("Add")
                                Image(systemName: "plus")
                            }
                        }
            }
            .sheet(isPresented: $isShowing, content: {
                AddActivities(action: userSelection, addMoreActivities: addAction).presentationDetents([.fraction(0.85), .large])
            })
            .navigationTitle("iHabit")
      
        }

    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ContentView(userSelection: Activities())
        }
    }
}
