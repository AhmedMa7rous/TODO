//
//  Todo.swift
//  TODO
//
//  Created by Ma7rous on 10/11/21.
//  Copyright © 2021 Ma7rous. All rights reserved.
//

import Foundation

struct Todos: Codable {
    let items: Array<Todo>
    
}

struct Todo: Codable {
    let item: String
    let priority: Int
}
