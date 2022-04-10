//
//  iCaloryApp.swift
//  iCalory
//
//  Created by Павел Кай on 10.04.2022.
//

import SwiftUI

@main
struct iCaloryApp: App {
    @StateObject private var dataContoller = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataContoller.container.viewContext)
        }
    }
}
