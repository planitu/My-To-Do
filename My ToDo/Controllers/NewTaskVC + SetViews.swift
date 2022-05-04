//
//  NewTaskVC + SetViews.swift
//  My ToDo
//
//  Created by Максим on 21.04.2022.
//

import UIKit

extension NewTaskVC {
    
     func setupViews() {
        
        switchTimeLimit.addTarget(self, action: #selector(switchChanged), for: .valueChanged)
        
        let priorityStackView: UIStackView = {
            let stackView = UIStackView(arrangedSubviews: [labelTaskPriority, segmentedControlPriority])
            stackView.axis = .horizontal
            stackView.spacing = 24
            stackView.distribution = .fillProportionally
            return stackView
        }()
        
        let timeLimitStackView: UIStackView = {
            let stackView = UIStackView(arrangedSubviews: [labelTaskTimeLimit, switchTimeLimit])
            stackView.axis = .horizontal
            stackView.spacing = 32
            stackView.distribution = .fillEqually
            return stackView
        }()
        
        completeStackView = {
          let stackView = UIStackView(arrangedSubviews: [priorityStackView, timeLimitStackView])
            stackView.axis = .vertical
            stackView.spacing = 24
            stackView.distribution = .fillEqually
            return stackView
        }()
        
        view.addSubview(upperLabel)
        view.addSubview(completeStackView)
        view.addSubview(nameTaskTextField)
        view.addSubview(descriptionTaskTextView)
        view.addSubview(datePicker)
        view.addSubview(cancelTaskButton)
        view.addSubview(createButton)
    }
    
    func setMyConstraints() {
        
        createButton.translatesAutoresizingMaskIntoConstraints = false
        cancelTaskButton.translatesAutoresizingMaskIntoConstraints = false
        upperLabel.translatesAutoresizingMaskIntoConstraints = false
        completeStackView.translatesAutoresizingMaskIntoConstraints = false
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        descriptionTaskTextView.translatesAutoresizingMaskIntoConstraints = false
        nameTaskTextField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            upperLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 48),
            upperLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            upperLabel.widthAnchor.constraint(equalToConstant: 220),
            
            nameTaskTextField.heightAnchor.constraint(equalToConstant: 42),
            nameTaskTextField.topAnchor.constraint(equalTo: upperLabel.bottomAnchor, constant: 32),
            nameTaskTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            nameTaskTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            
            descriptionTaskTextView.topAnchor.constraint(equalTo: nameTaskTextField.bottomAnchor, constant: 28),
            descriptionTaskTextView.heightAnchor.constraint(equalToConstant: 198),
            descriptionTaskTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            descriptionTaskTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            
            completeStackView.topAnchor.constraint(equalTo: descriptionTaskTextView.bottomAnchor, constant: 24),
            completeStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            completeStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            completeStackView.bottomAnchor.constraint(equalTo: datePicker.topAnchor, constant: -12),
                        
            datePicker.topAnchor.constraint(equalTo: completeStackView.bottomAnchor, constant: 64),
            datePicker.centerXAnchor.constraint(equalTo: view.centerXAnchor),
          
            createButton.heightAnchor.constraint(equalToConstant: 52),
            createButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            createButton.trailingAnchor.constraint(equalTo: cancelTaskButton.leadingAnchor, constant: -24),
            createButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -32),
            
            cancelTaskButton.heightAnchor.constraint(equalToConstant: 52),
            cancelTaskButton.widthAnchor.constraint(equalToConstant: 52),
            cancelTaskButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -18),
            cancelTaskButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -32)
            ])
    }
}
