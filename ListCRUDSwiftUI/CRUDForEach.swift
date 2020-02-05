//
//  CRUDForEach.swift
//  ListCRUDSwiftUI
//
//  Created by Vadym Bulavin on 2/5/20.
//  Copyright © 2020 Vadym Bulavin. All rights reserved.
//

import SwiftUI

struct CRUDForEach: View {
    @State private var items = Item.samples()
    
    var body: some View {
        NavigationView {
            ScrollView {
                ForEach(items) { item in
                    ItemView(item: item)
                        .modifier(ListRowModifier())
                }
                .onDelete(perform: onDelete)
            }
            .navigationBarTitle("CRUD ForEach")
            .navigationBarItems(leading: EditButton())
        }
    }
    
    private func onDelete(_ selection: IndexSet) {
        items.remove(at: selection)
    }
}

struct ItemView: View {
    let item: Item
    
    var body: some View {
        HStack {
            Text(item.title)
            Spacer()
        }
        .contentShape(Rectangle())
    }
}

struct ListRowModifier: ViewModifier {
    func body(content: Content) -> some View {
        Group {
            content
            Divider()
        }.offset(x: 20)
    }
}
