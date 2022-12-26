//
//  CallForHelpListView.swift
//  inLine
//
//  Created by Marina De Pazzi on 26/12/22.
//

import SwiftUI
import DequeModule

struct CallForHelpListView: View {
    @EnvironmentObject var viewModel: ViewModel
    
    @State private var popItem: String = ""
    @State private var viewSelection: Int = 1
    @State private var pickerOptions: [QueueStatusEnum] = [.all, .pending, .done]
    
    @State private var isPresentingSheet: Bool = false
    
    private var currentListShown: Deque<CallForHelp> {
        self.viewSelection == 1 ? self.viewModel.queue : self.viewModel.completedQueue
    }
    //TODO: Fix Picker + Fix completed requests not showing on other list
    var body: some View {
        VStack {
            Picker(selection: self.$viewSelection, content: {
                ForEach(self.pickerOptions, id: \.self) { option in
                    Text(option.description)
                }
            }, label: { })
            .pickerStyle(.segmented)
            .padding()
            
            List(self.currentListShown, id: \.self) { cfh in
                ListRowView(status: cfh.status, name: cfh.name, subject: cfh.subject, subjectArea: cfh.subjectArea)
                    .swipeActions(edge: .trailing, allowsFullSwipe: true, content: {
                        Button(role: .destructive, action: {
                            self.viewModel.completeCallForHelp()
                        }, label: {
                            Image(systemName: "checkmark.circle")
                        })
                        .tint(.green)
                    })
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
        .navigationTitle("Call for Help")
    }
}

struct ParticipantsListView_Previews: PreviewProvider {
    static var previews: some View {
        CallForHelpListView()
    }
}
