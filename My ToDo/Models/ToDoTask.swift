//
//  ToDoTask.swift
//  My ToDo
//
//  Created by Максим on 20.04.2022.
//

import UIKit

enum TaskPriority: String, Codable {
    case critically = "Важный"
    case normal = "Обычный"
}

struct ToDoTask: Codable {
    let name: String
    let description: String?
    let priority: TaskPriority
    let isTimeLimit: Bool
    let untilDate: Date?
    
    var inArchive: Bool
}
