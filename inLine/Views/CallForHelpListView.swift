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
    @State private var viewSelection: QueueStatusEnum = .pending
    @State private var pickerOptions: [QueueStatusEnum] = [.pending, .done, .all]
    
    @State private var isPresentingSheet: Bool = false
    @State private var isShowingDeleteAllAlert: Bool = false
    
    private var formatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .ordinal
        return formatter
    }
    
    private var queues: Binding<Deque<CallForHelp>> {
        Binding(get: {
            self.viewSelection == .pending ? self.viewModel.queue : self.viewSelection == .all ? (self.viewModel.queue + self.viewModel.completedQueue) : self.viewModel.completedQueue
        }, set: { _ in })
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
            
            List(0..<self.queues.count, id: \.self) { index in
                ListRowView(index: index, callForHelp: queues[index])
                    .swipeActions(edge: .trailing, allowsFullSwipe: true, content: {
                        if queues[index].status.wrappedValue == .pending {
                            Button(role: .destructive, action: {
                                self.viewModel.completeCallForHelp()
                            }, label: {
                                Image(systemName: "checkmark.circle")
                            })
                            .tint(.green)
                        }
                        
                        if queues[index].status.wrappedValue == .all || queues[index].status.wrappedValue == .done {
                            Button(role: .destructive, action: {
                                self.viewModel.completedQueue.removeAll(where: { $0 == queues[index].wrappedValue })
                            }, label: {
                                Image(systemName: "trash")
                            })
                            .tint(.red)
                            
                            Button(role: .cancel, action: {
                                self.viewModel.redoRequest(for: queues[index].wrappedValue)
                            }, label: {
                                Image(systemName: "arrow.uturn.backward")
                            })
                            .tint(.purple)
                        }
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
                
                
                ToolbarItem(placement: .navigationBarLeading, content: {
                    Button(action: {
                        self.isShowingDeleteAllAlert = true
                    }, label: {
                        Image(systemName: "trash")
                            .foregroundColor(.blue)
                    })
                })
            })
        }
        .alert(isPresented: self.$isShowingDeleteAllAlert, content: {
            Alert(title: Text("Are you sure you want to clear all queues?"), message: Text("This action will **remove** everyone from all queues"),primaryButton: .destructive(Text("Yes, clear queues"), action: {
                self.viewModel.queue.removeAll()
                self.viewModel.completedQueue.removeAll()
            }), secondaryButton: .cancel(Text("No, keep queues"), action: {
                self.isShowingDeleteAllAlert = false
            }))
        })
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
