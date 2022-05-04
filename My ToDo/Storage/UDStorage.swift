//
//  UDStorage.swift
//  My ToDo
//
//  Created by Максим on 21.04.2022.
//

import UIKit

enum UDStorageKeys: String {
    case activeTasks = "ActiveTasks"
    case archiveTasks = "ArchiveTasks"
}

class UDStorage {
    
    static let shared = UDStorage()
    
    var isActiveTasksNow = true
    var tasks: [ToDoTask] = []
    var activeTasks: [ToDoTask] = []
    var archiveTasks: [ToDoTask] = []
    
    func loadTasks() {
        
        let dataActiveTasks = UserDefaults.standard.data(forKey: UDStorageKeys.activeTasks.rawValue)
        if let data = dataActiveTasks {
            activeTasks = try! JSONDecoder().decode([ToDoTask].self, from: data)
        }
        
        let dataArchiveTasks = UserDefaults.standard.data(forKey: UDStorageKeys.archiveTasks.rawValue)
        if let data = dataArchiveTasks {
            archiveTasks = try! JSONDecoder().decode([ToDoTask].self, from: data)
        }
        
        tasks = activeTasks
    }
    
    func changeTasksTypeFlag() {
        if isActiveTasksNow {
            isActiveTasksNow = false
        } else {
            isActiveTasksNow = true
        }
    }
    
    func changeTasksType() {
        if isActiveTasksNow {
            tasks = activeTasks
        } else {
            tasks = archiveTasks
        }
    }
    
    func saveTasks() {
        
        if isActiveTasksNow {
            activeTasks = tasks
        } else {
            archiveTasks = tasks
        }
        
        let dataActiveTasks = try! JSONEncoder().encode(activeTasks)
        UserDefaults.standard.set(dataActiveTasks, forKey: UDStorageKeys.activeTasks.rawValue)
        
        let dataArchiveTasks = try! JSONEncoder().encode(archiveTasks)
        UserDefaults.standard.set(dataArchiveTasks, forKey: UDStorageKeys.archiveTasks.rawValue)
    }
}
