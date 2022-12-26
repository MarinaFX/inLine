//
//  ParticipantsListView.swift
//  inLine
//
//  Created by Marina De Pazzi on 26/12/22.
//

import SwiftUI
import DequeModule

struct ParticipantsListView: View {
    @State private var list = Deque<String>()
    @State private var popItem: String = ""
    @State private var viewSelection: Int = 0
    @State private var pickerOptions: [QueueStatusEnum] = [.all, .pending, .done]
    
    @State private var isPresentingSheet: Bool = false
    
    var body: some View {
        VStack {
            Picker(selection: self.$viewSelection, content: {
                ForEach(self.pickerOptions, id: \.self) { option in
                    Text(option.description)
                }
            }, label: { })
            .pickerStyle(.segmented)
            .padding()
            
            List(self.list, id: \.self) { student in
                ListRowView(status: .pending, name: "Kara Zor-El", subject: "Combine", subjectArea: .development)
            }
            .listStyle(.insetGrouped)
            
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarTrailing, content: {
                    Button(action: {
                        self.isPresentingSheet = true
                    }, label: {
                        Image(systemName: "person.crop.circle.badge.plus")
                            .foregroundColor(.blue)
                    })
                })
            })
        }
        .sheet(isPresented: self.$isPresentingSheet, content: {
            AddSubjectView()
        })
        .onAppear(perform: {
            self.list.append("flemis")
            self.list.append("flemis")
            self.list.append("flemis")
            self.list.append("flemis")
        })
        .navigationTitle("Call for Help")
    }
}

struct ParticipantsListView_Previews: PreviewProvider {
    static var previews: some View {
        ParticipantsListView()
    }
}
