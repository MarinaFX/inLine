//
//  ContentView.swift
//  inLine
//
//  Created by Marina De Pazzi on 07/12/22.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel: ViewModel = ViewModel()
    
    var body: some View {
        NavigationSplitView(sidebar: {
            #if os(iOS)
            CallForHelpListView()
                .environmentObject(self.viewModel)
            #endif
        }, detail: {
            CallForHelpListView()
                .environmentObject(self.viewModel)
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
