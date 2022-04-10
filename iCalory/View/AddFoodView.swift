//
//  AddFoodView.swift
//  iCalory
//
//  Created by Павел Кай on 10.04.2022.
//

import SwiftUI

struct AddFoodView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    
    @State private var name = ""
    @State private var calories: Double = 0
    
    var body: some View {
        Form {
            Section {
                TextField("Food Name", text: $name)
                
                VStack {
                    Text("Calories \(Int(calories))")
                    Slider(value: $calories, in: 0...1000, step: 2)
                }
                .padding()
                
                
                HStack {
                    Spacer()
                    Button("Submit") {
                        DataController().addFood(name: name, calories: calories, context: moc
                        )
                        dismiss()
                    }
                    Spacer()
                }
            }
        }
    }
}

struct AddFoodView_Previews: PreviewProvider {
    static var previews: some View {
        AddFoodView()
    }
}
