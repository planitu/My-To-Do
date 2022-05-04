//
//  DetailVC + SetViews.swift
//  My ToDo
//
//  Created by Максим on 27.04.2022.
//

import UIKit

extension DetailTaskVC {
    
    func setValues() {
        
        nameTaskLabel.text = detailTask.name
        
        if detailTask.description != nil && detailTask.description!.isNotEmpty {
            descriptionLabel.isHidden = false
            descriptionTaskLabel.isHidden = false
            descriptionTaskLabel.text = detailTask.description
        }
        
        descriptionScrollView.layer.cornerRadius = 5
        descriptionScrollView.layer.shadowOpacity = 0.7
        descriptionScrollView.layer.shadowRadius = 20
        descriptionScrollView.layer.shadowColor = #colorLiteral(red: 0, green: 0.7896973491, blue: 1, alpha: 0.2976601708).cgColor
                        
        if detailTask.inArchive {
            priorityTaskLabel.textColor = .darkGray
            priorityTaskLabel.layer.shadowColor = UIColor.darkGray.cgColor
            priorityTaskLabel.text = "Выполнено"
        } else if detailTask.priority == .critically {
            priorityTaskLabel.textColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
            priorityTaskLabel.layer.shadowColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1).cgColor
            priorityTaskLabel.text = detailTask.priority.rawValue
        }
        else if detailTask.priority == .normal {
            priorityTaskLabel.textColor = #colorLiteral(red: 0, green: 0.9768045545, blue: 0, alpha: 1)
            priorityTaskLabel.layer.shadowColor = #colorLiteral(red: 0, green: 0.9768045545, blue: 0, alpha: 1).cgColor
            priorityTaskLabel.text = detailTask.priority.rawValue
            
        }
        
        if detailTask.isTimeLimit {
            let dateString = detailTask.untilDate!.toString("EEEE · d MMMM yyyy · HH:mm")
            dateTaskLabel.text = dateString
        } else {
            dateTaskLabel.text = "♾"
        }
    }
    
    func setConstraints() {
        
        nameStackView.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionScrollView.translatesAutoresizingMaskIntoConstraints = false
        descriptionTaskLabel.translatesAutoresizingMaskIntoConstraints = false
        priorityAndDateStackView.translatesAutoresizingMaskIntoConstraints = false
        changeButton.translatesAutoresizingMaskIntoConstraints = false
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            
            nameStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 84),
            nameStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            nameStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            
            descriptionLabel.topAnchor.constraint(equalTo: nameStackView.bottomAnchor, constant: 32),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            
            descriptionScrollView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 12),
            descriptionScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            descriptionScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            descriptionScrollView.bottomAnchor.constraint(equalTo: priorityAndDateStackView.topAnchor, constant: -28),
            
            descriptionTaskLabel.widthAnchor.constraint(equalTo: descriptionScrollView.widthAnchor),
            descriptionTaskLabel.topAnchor.constraint(equalTo: descriptionScrollView.topAnchor),
            descriptionTaskLabel.trailingAnchor.constraint(equalTo: descriptionScrollView.trailingAnchor),
            descriptionTaskLabel.leadingAnchor.constraint(equalTo: descriptionScrollView.leadingAnchor),
            descriptionTaskLabel.bottomAnchor.constraint(equalTo: descriptionScrollView.bottomAnchor),
            
            priorityAndDateStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            priorityAndDateStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            priorityAndDateStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -98),
            
            changeButton.heightAnchor.constraint(equalToConstant: 52),
            changeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 22),
            changeButton.trailingAnchor.constraint(equalTo: deleteButton.leadingAnchor, constant: -24),
            changeButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -32),
            
            deleteButton.heightAnchor.constraint(equalToConstant: 52),
            deleteButton.widthAnchor.constraint(equalToConstant: 52),
            deleteButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -18),
            deleteButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -32)
        ])
    }
}
