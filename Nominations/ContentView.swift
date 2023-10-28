//
//  ContentView.swift
//  Nominations
//
//  Created by Sam Davis on 20/10/2023.
//  Copyright © 2023 3 Sided Cube (UK) Ltd. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @StateObject var homeVM = HomeViewModel()
    var body: some View {
        HomeView()
            .environmentObject(homeVM)
    }
}

#Preview {
    ContentView()
}
