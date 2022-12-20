//
//  ContentView.swift
//  inLine
//
//  Created by Marina De Pazzi on 07/12/22.
//

import SwiftUI
import DequeModule

struct ContentView: View {
    
    var body: some View {
        NavigationSplitView(sidebar: {
            #if os(iOS)
            ParticipantList()
            #endif
        }, detail: {
            ParticipantList()
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        //ContentView()
        NavigationView(content: {
            AddSubject()
        })
    }
}

//MARK: - ParticipantList
struct ParticipantList: View {
    @State private var list = Deque<String>()
    @State private var popItem: String = ""
    @State private var viewSelection: Int = 0
    @State private var pickerOptions: [QueueStatus] = [.all, .pending, .done]
    
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
            AddSubject()
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

//MARK: - ListRowView
struct ListRowView: View {
    //eye.square.fill - Design
    //curlybraces.square.fill - Dev
    
    @State var status: QueueStatus = .pending
    @State var name: String = "Kara Zor-El"
    @State var subject: String = "Combine"
    @State var subjectArea: SubjectArea = .development
    
    var body: some View {
        HStack {
            Image(systemName: self.subjectArea == .development ? "curlybraces.square.fill" : "eye.square.fill")
                .font(.largeTitle)
                .foregroundColor(self.status == .pending ? .orange : .green)
            
            VStack(alignment: .leading) {
                Text(self.name)
                    .font(.body)
                    .fontWeight(.medium)
                
                Text(self.subject)
                    .font(.callout)
                    .foregroundColor(.accentColor)
            }
            
            Spacer()
            
            Text("1st")
        }
    }
}

//MARK: - AddSubject
struct AddSubject: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var nameText: String = ""
    @State private var subjectText: String = ""
    
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                Text("Name")
                    .fontWeight(.medium)
                    .padding(.top)
                
                TextField("Type your name", text: self.$nameText)
                    .padding()
                    .overlay(content: {
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(lineWidth: 1)
                    })
                    .padding(.bottom)
                
                Text("Subject")
                    .fontWeight(.medium)
                
                TextField("Type the subject", text: self.$subjectText)
                    .padding()
                    .overlay(content: {
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(lineWidth: 1)
                    })
            }
            .padding(.horizontal)
            .padding(.vertical, 2)
            
            Spacer()
            
            Button(action: {
                
            }, label: {
                Text("Add")
                    .padding(.horizontal, 32)
                    .padding(.vertical, 8)
                    .foregroundColor(.white)
                    .bold()
            })
            .background(Color.blue)
            .cornerRadius(8)
            .padding()
                      
            .toolbar(content: {
                ToolbarItem(placement: .automatic, content: {
                    Button(action: {
                        self.dismiss()
                    }, label: {
                        Text("Cancel")
                    })
                    .buttonStyle(.automatic)
                })
                
                ToolbarItem(placement: .automatic, content: {
                    Button(action: {
                        //TODO: Save and Dismiss
                    }, label: {
                        Text("Done")
                            .bold()
                    })
                    .buttonStyle(.automatic)
                })
            })
        }
        .navigationTitle("Add Request")
        .navigationBarTitleDisplayMode(.inline)
    }
}

//MARK: - QueueStatus
//TODO: - Move to separate file
enum QueueStatus: CustomStringConvertible {
    case all
    case done
    case pending
    
    var description: String {
        switch self {
            case .all:
                return "All"
            case .done:
                return "Done"
            case .pending:
                return "Pending"
        }
    }
}

//MARK: - SubjectArea
//TODO: - Move to separate file
enum SubjectArea: CustomStringConvertible {
    case design
    case development
    
    var description: String {
        switch self {
            case .design:
                return "Design"
            case .development:
                return "Development"
        }
    }
}
