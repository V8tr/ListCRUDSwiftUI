//
//  Steps.swift
//  ListCRUDSwiftUI
//
//  Created by Vadym Bulavin on 2/10/20.
//  Copyright © 2020 Vadym Bulavin. All rights reserved.
//

import SwiftUI

enum Step1 {
    struct DemoList: View {
        @State private var items: [Item] = (0..<10).map { Item(title: "Item #\($0)") }

        var body: some View {
            List {
                ForEach(items) { item in
                    Text(item.title)
                }
            }
        }
    }
}
