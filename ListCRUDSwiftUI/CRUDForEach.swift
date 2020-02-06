//
//  CRUDForEach.swift
//  ListCRUDSwiftUI
//
//  Created by Vadym Bulavin on 2/5/20.
//  Copyright © 2020 Vadym Bulavin. All rights reserved.
//

import SwiftUI
import MobileCoreServices

struct CRUDForEach: View {
    @State private var items: [Item] = [Item(title: "Item #0"), Item(title: "Item #1")]
    @State private var editMode: EditMode = .inactive
    static var count = 2
    
    var body: some View {
        NavigationView {
            List {
                ForEach(items) { item in
                    ItemView(item: item)
                }
                .onDelete(perform: onDelete)
                .onMove(perform: onMove)
                .onInsert(of: [String(kUTTypeURL)], perform: onInsert)
            }
            .navigationBarTitle("CRUD ForEach")
            .navigationBarItems(leading: EditButton(), trailing: addButton)
            .environment(\.editMode, $editMode)
        }
    }
    
    private var addButton: some View {
        switch editMode {
        case .inactive:
            return AnyView(Button(action: onAdd) { Image(systemName: "plus") })
        default:
            return AnyView(EmptyView())
        }
    }
    
    private func onDelete(offsets: IndexSet) {
        items.remove(atOffsets: offsets)
    }
    
    private func onMove(src: IndexSet, dst: Int) {
        items.move(fromOffsets: src, toOffset: dst)
    }
    
    private func onInsert(at offset: Int, itemProvider: [NSItemProvider]) {
        for provider in itemProvider {
            if provider.hasItemConformingToTypeIdentifier(String(kUTTypeURL)) {
                _ = provider.loadObject(ofClass: URL.self) { url, error in
                    url.map { self.items.insert(Item(title: $0.absoluteString), at: offset) }
                }
            }
        }
    }
    
    private func onAdd() {
        items.append(Item(title: "Item #\(Self.count)"))
        Self.count += 1
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
