//
//  CRUDList.swift
//  ListCRUDSwiftUI
//
//  Created by Vadym Bulavin on 2/5/20.
//  Copyright © 2020 Vadym Bulavin. All rights reserved.
//

import SwiftUI

struct Item: Identifiable, Hashable {
    let id = UUID()
    let title: String
}

struct CRUDList: View {
    @State private var items: [Item] = []
    @State private var selection: Set<Item.ID> = []
    @State private var editMode: EditMode = .inactive
    private static var count = 0
    
    let x = EditButton()
    
    var body: some View {
        NavigationView {
            List(items, selection: $selection) { item in
                Text(item.title)
            }
            .navigationBarTitle(Text("CRUD List"))
            .navigationBarItems(leading: editOrDoneButton, trailing: addOrDeleteButton)
            .environment(\.editMode, $editMode)
        }
    }
    
    private var editOrDoneButton: some View {
        switch editMode {
        case .inactive:
            return Button(action: onEdit) { Text("Edit") }
        default:
            return Button(action: onDone) { Text("Done") }
        }
    }
    
    private var addOrDeleteButton: some View {
        switch editMode {
        case .inactive:
            return Button(action: onAdd) { Image(systemName: "plus") }
        default:
            return Button(action: onDelete) { Image(systemName: "trash") }
        }
    }
    
    private func onEdit() {
        editMode = .active
    }
    
    private func onDone() {
        editMode = .inactive
    }
    
    private func onAdd() {
        items.append(Item(title: "Item #\(Self.count)"))
        Self.count += 1
    }
    
    private func onDelete() {
        items.removeAll { item in selection.contains { $0 == item.id } }
        selection = []
    }
}
