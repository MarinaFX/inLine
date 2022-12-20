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

struct ParticipantList: View {
    @State var list = Deque<String>()
    @State var popItem: String = ""
    @State var viewSelection: Int = 0
    
    var body: some View {
        VStack {
            
            Picker("flemis", selection: self.$viewSelection, content: {
                Text("Pendentes").tag(0)
                Text("Atendidos").tag(1)
            })
            .padding()
            .pickerStyle(SegmentedPickerStyle())
            .foregroundColor(Color.red)
            
            if viewSelection == 0 {
                List(self.list.indexed(), id: \.1.self) { index, item in
                    HStack {
                        Text("\(index+1)")
                        Text(item)
                    }
                }
                .onAppear(perform: {
                    self.list.append("Marcelo")
                    self.list.append("Marina")
                    self.list.prepend("Brenda")
                    self.list.append("Thais")
                })
            }
            else {
                Text("teste")
            }
        }
        .navigationTitle("Duvidas")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


struct IndexedCollection<Base: RandomAccessCollection>: RandomAccessCollection {
    typealias Index = Base.Index
    typealias Element = (index: Index, element: Base.Element)

    let base: Base

    var startIndex: Index { base.startIndex }

   // corrected typo: base.endIndex, instead of base.startIndex
    var endIndex: Index { base.endIndex }

    func index(after i: Index) -> Index {
        base.index(after: i)
    }

    func index(before i: Index) -> Index {
        base.index(before: i)
    }

    func index(_ i: Index, offsetBy distance: Int) -> Index {
        base.index(i, offsetBy: distance)
    }

    subscript(position: Index) -> Element {
        (index: position, element: base[position])
    }
}

extension RandomAccessCollection {
    func indexed() -> IndexedCollection<Self> {
        IndexedCollection(base: self)
    }
}
