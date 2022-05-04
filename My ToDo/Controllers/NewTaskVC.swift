//
//  NewTaskVC.swift
//  My ToDo
//
//  Created by Максим on 20.04.2022.
//

import UIKit

class NewTaskVC: UIViewController {
    
    var numberTask: Int!
    var completeStackView = UIStackView()
    
    let upperLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .black
        label.font = UIFont(name: "GillSans", size: 28)
        label.text = "Создание задачи"
        return label
    }()
    
    let nameTaskTextField: HoshiTextField = {
        let textField = HoshiTextField()
        textField.text = nil
        textField.textColor = .black
        textField.placeholder = "Название задачи"
        textField.tintColor = .green
        textField.placeholderColor = .darkGray
        textField.borderActiveColor = .green
        textField.borderInactiveColor = .red
        textField.autocapitalizationType = .sentences
        textField.smartDashesType = .no
        textField.returnKeyType = .done
        textField.autocorrectionType = .no
        textField.enablesReturnKeyAutomatically = true
        textField.clearButtonMode = .whileEditing
        return textField
    }()
    
    let descriptionTaskTextView: UITextView = {
        let textView = UITextView()
        textView.text = "Введите описание(необязательно)"
        textView.textColor = UIColor.black
        textView.backgroundColor = .clear
        textView.layer.borderColor = UIColor.green.cgColor
        textView.layer.borderWidth = 3
        textView.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 18)
        textView.allowsEditingTextAttributes = true
        textView.returnKeyType = .done
        textView.autocapitalizationType = .sentences
        textView.autocorrectionType = .no
        textView.keyboardDismissMode = .onDrag
        textView.isEditable = true
        textView.layer.cornerRadius = 9
        textView.textContainerInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        return textView
    }()
    
    let labelTaskPriority: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "Приоритет"
        return label
    }()
    
    let segmentedControlPriority: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: [TaskPriority.critically.rawValue, TaskPriority.normal.rawValue])
        segmentedControl.selectedSegmentIndex = 1
        segmentedControl.selectedSegmentTintColor = .green
        segmentedControl.apportionsSegmentWidthsByContent = true
        segmentedControl.addTarget(self, action: #selector(segmentedControlColorDidChanged), for: .valueChanged)
        return segmentedControl
    }()
    
    let labelTaskTimeLimit: UILabel = {
        let label = UILabel()
        label.text = "Сделать до"
        label.textColor = .black
        return label
    }()
    
    let switchTimeLimit: AIFlatSwitch = {
        let mySwitch = AIFlatSwitch()
        mySwitch.strokeColor = .lightGray
        mySwitch.trailStrokeColor = .clear
        return mySwitch
    }()
    
    let datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.backgroundColor = .black
        picker.datePickerMode = .dateAndTime
        picker.backgroundColor = .clear
        picker.locale = Locale(identifier: "ru_RU")
        picker.tintColor = #colorLiteral(red: 0, green: 0.5628422499, blue: 0.3188166618, alpha: 1)
        picker.clipsToBounds = true
        picker.layer.cornerRadius = 7
        picker.isHidden = true
        return picker
    }()
    
    let cancelTaskButton: UIButton = {
       let button = UIButton()
        button.setImage(UIImage(systemName: "multiply"), for: .normal)
        button.backgroundColor = .darkGray
        button.tintColor = .green
        button.layer.cornerRadius = 26
        button.addTarget(self, action: #selector(cancelTaskButtonDidTapped), for: .touchUpInside)
        return button
    }()

    let createButton: UIButton = {
       let button = UIButton()
        button.setTitle("Создать", for: .normal)
        button.setTitleColor(.darkGray, for: .normal)
        button.setTitleColor(.lightGray, for: .highlighted)
        button.backgroundColor = .green
        button.layer.cornerRadius = 15
        button.addTarget(self, action: #selector(createButtonDidTapped), for: .touchUpInside)
        return button
    }()
  
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        nameTaskTextField.delegate = self
        descriptionTaskTextView.delegate = self
        
        setupViews()
        setMyConstraints()
    }
}
