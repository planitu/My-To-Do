//
//  TaskTVCell.swift
//  My ToDo
//
//  Created by Максим on 20.04.2022.
//

import UIKit

class TaskTVCell: UITableViewCell {

    let nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont(name: "Georgia", size: 19)
        return label
    }()
    
    let dateLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont(name: "SnellRoundhand-Bold", size: 18)
        return label
    }()
    
    let priorityLabel: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.layer.shadowRadius = 7.0
        label.layer.shadowOpacity = 5.0
        label.layer.shadowOffset = CGSize(width: 2, height: 2)
        return label
    }()
    
    
    func configure(with task: ToDoTask) {
        
        nameLabel.text = "\(task.name)"

        if task.inArchive {
            priorityLabel.textColor = .darkGray
            priorityLabel.layer.shadowColor = UIColor.darkGray.cgColor
            priorityLabel.text = "Выполнено"
        } else if task.priority == .critically {
            priorityLabel.textColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
            priorityLabel.layer.shadowColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1).cgColor
            priorityLabel.text = task.priority.rawValue
        }
        else if task.priority == .normal {
            priorityLabel.textColor = #colorLiteral(red: 0, green: 0.6619602442, blue: 0.3522694707, alpha: 1)
            priorityLabel.layer.shadowColor = #colorLiteral(red: 0, green: 0.6619602442, blue: 0.3522694707, alpha: 1).cgColor
            priorityLabel.text = task.priority.rawValue
        }
        
        if task.isTimeLimit {
            let dateString = task.untilDate!.toString("d MMMM yyyy · HH:mm")
            dateLabel.text = dateString
        } else {
            dateLabel.text = "♾"
        }
        
        addSubview(nameLabel)
        addSubview(dateLabel)
        addSubview(priorityLabel)
        
        setConstraints()
//        setBackground()
    }
    
//    private func setBackground() {
//        let gradientLayer = CAGradientLayer()
//        gradientLayer.frame = layer.bounds
//        gradientLayer.colors = [UIColor.purple.cgColor, UIColor.blue.cgColor]
//        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
//        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
//        layer.insertSublayer(gradientLayer, at: 1)
//    }
    
    private func setConstraints() {
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        priorityLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
        
            nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            
            dateLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 24),
            dateLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            dateLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            dateLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12),
            
            priorityLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            priorityLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)
        ])
    }
}
