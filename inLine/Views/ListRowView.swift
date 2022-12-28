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
    
    @State private var formattedPosition: String = ""
    @State var index: Int = 0
    
    @Binding var callForHelp: CallForHelp
    
    private var formatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .ordinal
        return formatter
    }
    
    var body: some View {
        HStack {
            Image(systemName: self.callForHelp.subjectArea == .development ? "curlybraces.square.fill" : "eye.square.fill")
                .font(.largeTitle)
                .foregroundColor(self.callForHelp.status == .pending ? .orange : .green)
            
            VStack(alignment: .leading) {
                Text(self.callForHelp.name)
                    .font(.body)
                    .fontWeight(.medium)
                
                Text(self.callForHelp.subject)
                    .font(.callout)
                    .foregroundColor(.accentColor)
            }
            
            Spacer()
            
            Text(self.formattedPosition)
        }
        .onAppear(perform: {
            self.formattedPosition = formatter.string(from: NSNumber(value: UInt(self.index) + 1)) ?? ""
        })
    }
}

struct ListRowView_Previews: PreviewProvider {
    static var previews: some View {
        ListRowView(callForHelp: .constant(CallForHelp()))
    }
}
