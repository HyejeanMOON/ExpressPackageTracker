//
//  ExpressPackageTrackerApp.swift
//  ExpressPackageTracker
//
//  Created by MOON on 2023/05/28.
//

import SwiftUI

@main
struct ExpressPackageTrackerApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ExpressCompanyListView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
