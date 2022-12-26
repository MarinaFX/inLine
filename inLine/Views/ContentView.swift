//
//  ContentView.swift
//  inLine
//
//  Created by Marina De Pazzi on 07/12/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationSplitView(sidebar: {
            #if os(iOS)
            ParticipantsListView()
            #endif
        }, detail: {
            ParticipantsListView()
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
