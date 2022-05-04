//
//  DetailTaskVC + Functions + .swift
//  My ToDo
//
//  Created by Максим on 27.04.2022.
//

import UIKit

extension DetailTaskVC {
    
    @objc func changeButtonDidTapped() {
        
        if UDStorage.shared.isActiveTasksNow {
            let changeVC = NewTaskVC()
            
            changeVC.numberTask = taskIndexPath.section
            changeVC.upperLabel.text = "Изменить задачу"
            changeVC.createButton.setTitle("ОК", for: .normal)
            changeVC.nameTaskTextField.text = detailTask.name
            changeVC.descriptionTaskTextView.text = detailTask.description
            
            if detailTask.priority == .normal {
                changeVC.segmentedControlPriority.selectedSegmentIndex = 1
                changeVC.segmentedControlPriority.selectedSegmentTintColor = #colorLiteral(red: 0, green: 0.9768045545, blue: 0, alpha: 1)
            } else if detailTask.priority == .critically {
                changeVC.segmentedControlPriority.selectedSegmentIndex = 0
                changeVC.segmentedControlPriority.selectedSegmentTintColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
            }
            
            if detailTask.isTimeLimit{
                changeVC.switchTimeLimit.isSelected = true
                changeVC.switchTimeLimit.strokeColor = .green
                changeVC.animateDatePickerShow()
            } else {
                changeVC.switchTimeLimit.isSelected = false
            }
            
            if let date = detailTask.untilDate {
                changeVC.datePicker.date = date
            }
            
            changeVC.modalPresentationStyle = .fullScreen
            Haptic.impact(.soft).generate()
            present(changeVC, animated: true, completion: nil)
        } else {
            Haptic.notification(.success).generate()
            UDStorage.shared.tasks[taskIndexPath.section].inArchive = false
            let newActiveTask = UDStorage.shared.tasks[taskIndexPath.section]
            UDStorage.shared.activeTasks.insert(newActiveTask, at: 0)
            UDStorage.shared.tasks.remove(at: taskIndexPath.section)
        }
        navigationController?.popViewController(animated: true)
    }
    
    
    @objc func deleteButtonDidTapped() {
        UDStorage.shared.tasks.remove(at: taskIndexPath.section)
        Haptic.notification(.error).generate()
        navigationController?.popViewController(animated: true)
    }
    
    
    func setNameStackView() -> UIStackView {
        
        let nameStackView: UIStackView = {
            let stackView = UIStackView(arrangedSubviews: [nameLabel, nameTaskLabel])
            stackView.axis = .vertical
            stackView.spacing = 14
            stackView.distribution = .fillProportionally
            return stackView
        }()
        return nameStackView
    }
    
    
    func setPriorityAndDateStackView() -> UIStackView {
        let priorityStackView: UIStackView = {
            let stackView = UIStackView(arrangedSubviews: [priorityLabel, priorityTaskLabel])
            stackView.axis = .horizontal
            stackView.spacing = view.bounds.width/3
            stackView.distribution = .fillProportionally
            return stackView
        }()
        
        let dateStackView: UIStackView = {
            let stackView = UIStackView(arrangedSubviews: [dateLabel, dateTaskLabel])
            stackView.axis = .vertical
            stackView.spacing = 12
            stackView.alignment = .leading
            stackView.distribution = .fillProportionally
            return stackView
        }()
        
        let completeTaskStackView: UIStackView = {
            let stackView = UIStackView(arrangedSubviews: [priorityStackView, dateStackView])
            stackView.axis = .vertical
            stackView.spacing = 24
            stackView.alignment = .leading
            stackView.distribution = .fillProportionally
            return stackView
        }()
        return completeTaskStackView
    }
    
}
