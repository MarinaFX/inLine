//
//  ListRowView.swift
//  inLine
//
//  Created by Marina De Pazzi on 26/12/22.
//

import SwiftUI

struct ListRowView: View {
    //eye.square.fill - Design
    //curlybraces.square.fill - Dev
    
    @State var status: QueueStatusEnum = .pending
    @State var name: String = "Kara Zor-El"
    @State var subject: String = "Combine"
    @State var subjectArea: SubjectAreaEnum = .development
    
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

struct ListRowView_Previews: PreviewProvider {
    static var previews: some View {
        ListRowView()
    }
}
