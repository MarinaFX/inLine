//
//  AddSubjectView.swift
//  inLine
//
//  Created by Marina De Pazzi on 26/12/22.
//

import SwiftUI

struct AddSubjectView: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var nameText: String = ""
    @State private var subjectText: String = ""
    @State private var subjectArea: SubjectAreaEnum = .development
    
    private var pickerOptions: [SubjectAreaEnum] = [.development, .design]
    
    
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
                    .padding(.bottom)
                
                Text("Area of Subject")
                    .fontWeight(.medium)
                
                Picker("Type the subject", selection: self.$subjectArea, content: {
                    ForEach(self.pickerOptions, id: \.self, content: { option in
                        Text(option.description)
                    })
                })
                .pickerStyle(.menu)
                    
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

struct AddSubjectView_Previews: PreviewProvider {
    static var previews: some View {
        AddSubjectView()
    }
}
