//
//  MainVC + TableView.swift
//  My ToDo
//
//  Created by Максим on 20.04.2022.
//

import UIKit

extension MainVC: UITableViewDelegate, UITableViewDataSource {
    
    func animatedTableViewShow() {
        let cells = tasksTableView.visibleCells
        let tableViewHeight = tasksTableView.bounds.height
        var deley = 0.1
        for cell in cells {
            cell.transform = CGAffineTransform(translationX: 0, y: tableViewHeight)
            
            UIView.animate(withDuration: 0.5,
                           delay: deley,
                           usingSpringWithDamping: 1,
                           initialSpringVelocity: 12,
                           options: .allowUserInteraction,
                           animations: { cell.transform = CGAffineTransform.identity },
                           completion: { _ in Haptic.impact(.soft).generate() })
            deley += 0.04
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return UDStorage.shared.tasks.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tasksTableView.dequeueReusableCell(withIdentifier: "reuseTaskCell", for: indexPath) as! TaskTVCell
        cell.configure(with: UDStorage.shared.tasks[indexPath.section])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let detailVC = DetailTaskVC()
        detailVC.taskIndexPath = indexPath
        
        if UDStorage.shared.isActiveTasksNow == false {
            detailVC.changeButton.setTitle("Восстановить", for: .normal)
        }
        
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteSwipeAction = UIContextualAction(style: .destructive, title: "Удалить") { _, _, _ in
            UDStorage.shared.tasks.remove(at: indexPath.section)
            self.tasksTableView.deleteSections([indexPath.section], with: .left)
        }
        return UISwipeActionsConfiguration(actions: [deleteSwipeAction])
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        if UDStorage.shared.isActiveTasksNow {
            let addToArchiveAction = UIContextualAction(style: .normal, title: "Выполнено") { _, _, _ in
                UDStorage.shared.tasks[indexPath.section].inArchive = true
                let newArchiveTask = UDStorage.shared.tasks[indexPath.section]
                UDStorage.shared.archiveTasks.insert(newArchiveTask, at: 0)
                UDStorage.shared.tasks.remove(at: indexPath.section)
                self.tasksTableView.deleteSections([indexPath.section], with: .right)
            }
            return UISwipeActionsConfiguration(actions: [addToArchiveAction])
        } else {
            
            let returnToActiveAction = UIContextualAction(style: .normal, title: "Восстановить") { _, _, _ in
                UDStorage.shared.tasks[indexPath.section].inArchive = false
                let newActiveTask = UDStorage.shared.tasks[indexPath.section]
                UDStorage.shared.activeTasks.insert(newActiveTask, at: 0)
                UDStorage.shared.tasks.remove(at: indexPath.section)
                self.tasksTableView.deleteSections([indexPath.section], with: .right)
            }
            return UISwipeActionsConfiguration(actions: [returnToActiveAction])
        }
    }
}
