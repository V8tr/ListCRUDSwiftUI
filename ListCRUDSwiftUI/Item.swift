//
//  Item.swift
//  ListCRUDSwiftUI
//
//  Created by Vadym Bulavin on 2/7/20.
//  Copyright © 2020 Vadym Bulavin. All rights reserved.
//

import Foundation

struct Item: Identifiable, Hashable {
    let id = UUID()
    let title: String
}
