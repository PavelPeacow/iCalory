//
//  ContentView.swift
//  iCalory
//
//  Created by Павел Кай on 10.04.2022.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: [SortDescriptor(\.date, order: .reverse)]) var food: FetchedResults<Food>
    
    @State private var showAddView = false
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                
                Text("\(Int(totalCaloriesToday())) Kcal (Today)")
                    .foregroundColor(.gray)
                    .padding()
                List {
                    ForEach(food) { food in
                        NavigationLink {
                            EditFoodView(food: food)
                        } label: {
                            HStack {
                                VStack(alignment: .leading, spacing: 6) {
                                    Text(food.name!)
                                        .bold()
                                    
                                    Text("\(Int(food.calories))") + Text(" Calories")
                                        .foregroundColor(.green)
                                }
                                Spacer()
                                Text(calcTime(date: food.date!))
                                    .foregroundColor(.gray)
                                    .italic()
                            }
                        }

                    }
                    .onDelete(perform: deleteFood)
                }
                .listStyle(.plain)
            }
            .navigationTitle("Calories")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showAddView.toggle()
                    } label: {
                        Label("Add Food", systemImage: "plus.circle")
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
            }
            .sheet(isPresented: $showAddView) {
                AddFoodView()
            }
        }

    }

    
    
    private func deleteFood(offsets: IndexSet) {
        withAnimation {
            offsets.map { food[$0] }.forEach(moc.delete)
            
            DataController().save(context: moc)
        }
    }
    
    
    private func totalCaloriesToday() -> Double {
        var caloriesToday: Double = 0
        
        for item in food {
            if Calendar.current.isDateInToday(item.date!) {
                caloriesToday += item.calories
            }
        }
        
        return caloriesToday
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
