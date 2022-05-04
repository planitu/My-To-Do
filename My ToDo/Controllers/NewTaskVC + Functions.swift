//
//  NewTaskVC + Functions.swift
//  My ToDo
//
//  Created by Максим on 27.04.2022.
//

import UIKit

extension NewTaskVC {
    
    @objc func createButtonDidTapped() {
        guard let task = createTask() else { Haptic.notification(.warning).generate(); return }
        
        if task.isTimeLimit {
            createNotification(for: task)
        }
        if numberTask != nil {
            UDStorage.shared.tasks[numberTask] = task
        } else {
            UDStorage.shared.tasks.insert(task, at: 0)
        }
        presentingViewController?.loadViewIfNeeded()
        Haptic.notification(.success).generate()
        dismiss(animated: true)
    }
    
    func createNotification(for task: ToDoTask) {
        let content = UNMutableNotificationContent()
        content.title = "Напоминание о задаче"
        content.body = task.name
        content.sound = UNNotificationSound.defaultCritical
        content.badge = 1
        
        let triggerDate = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: task.untilDate!)
        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: false)
        
        let identifier = "Local Notification"
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
    
    func createTask() -> ToDoTask? {
        
        var date: Date?
        var description: String?
        var priority: TaskPriority = .normal
        
        if segmentedControlPriority.selectedSegmentIndex == 0 {
            priority = .critically
        } else if segmentedControlPriority.selectedSegmentIndex == 1 {
            priority = .normal
        }
        
        if !nameTaskTextField.text!.isNotEmpty {
            nameTaskTextField.shake()
            return nil
        }
    
        if descriptionTaskTextView.text != "Введите описание(необязательно)" {
            description = descriptionTaskTextView.text
        }
        
        if switchTimeLimit.isSelected {
            date = datePicker.date
        }
        
        let task = ToDoTask(name: nameTaskTextField.text!, description: description, priority: priority, isTimeLimit: switchTimeLimit.isSelected, untilDate: date, inArchive: false)
        return task
    }
    
    @objc func cancelTaskButtonDidTapped() {
        Haptic.impact(.soft).generate()
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func switchChanged() {
        Haptic.impact(.rigid).generate()
        if switchTimeLimit.isSelected {
            animateDatePickerShow()
            switchTimeLimit.strokeColor = .green
        } else if !switchTimeLimit.isSelected {
            animateDatePickerHide()
            switchTimeLimit.strokeColor = .lightGray
        }
    }
    
    @objc func segmentedControlColorDidChanged() {
        Haptic.impact(.light).generate()
        if segmentedControlPriority.selectedSegmentIndex == 0 {
            segmentedControlPriority.selectedSegmentTintColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
        } else if segmentedControlPriority.selectedSegmentIndex == 1 {
            segmentedControlPriority.selectedSegmentTintColor = #colorLiteral(red: 0, green: 0.9768045545, blue: 0, alpha: 1)
        }
    }
    
    func animateDatePickerShow() {
        datePicker.isHidden = false
        datePicker.transform = CGAffineTransform(translationX: 300, y: 0)
        
        UIView.animate(withDuration: 0.6,
                       delay: 0,
                       usingSpringWithDamping: 12,
                       initialSpringVelocity: 22,
                       options: .curveEaseOut,
                       animations: { self.datePicker.transform = CGAffineTransform.identity },
                       completion: nil)
    }
    
    func animateDatePickerHide() {
        datePicker.transform = CGAffineTransform(translationX: 0, y: 0)

        UIView.animate(withDuration: 0.35,
                       delay: 0,
                       usingSpringWithDamping: 2,
                       initialSpringVelocity: 1,
                       options: .curveEaseOut,
                       animations: { self.datePicker.transform = CGAffineTransform(translationX: 360, y: 0) }) { _ in self.datePicker.isHidden = true }
    }
}
