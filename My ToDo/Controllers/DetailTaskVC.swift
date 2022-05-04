//
//  DetailTaskVC.swift
//  My ToDo
//
//  Created by Максим on 20.04.2022.
//

import UIKit

class DetailTaskVC: UIViewController {

    var taskIndexPath: IndexPath!
    var detailTask: ToDoTask!
    var nameStackView: UIStackView!
    var priorityAndDateStackView: UIStackView!
    lazy var descriptionScrollView = UIScrollView()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Название:"
        label.textColor = .black
        label.font = UIFont(name: "HelveticaNeue-Italic", size: 18)
        label.layer.shadowOpacity = 1
        label.layer.shadowRadius = 5.0
        label.layer.shadowOffset = CGSize(width: 6, height: 4)
        label.layer.shadowColor = #colorLiteral(red: 0.004984250292, green: 0.2071827948, blue: 0.01191163901, alpha: 0.749474936)
        return label
    }()
    
    let nameTaskLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 0
        label.font = UIFont(name: "Georgia-Bold", size: 18)
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Описание:"
        label.textColor = .black
        label.isHidden = true
        label.font = UIFont(name: "HelveticaNeue-Italic", size: 18)
        label.layer.shadowOpacity = 1
        label.layer.shadowRadius = 5.0
        label.layer.shadowOffset = CGSize(width: 6, height: 4)
        label.layer.shadowColor = #colorLiteral(red: 0.004984250292, green: 0.2071827948, blue: 0.01191163901, alpha: 0.749474936)
        return label
    }()
    
    let descriptionTaskLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .black
        label.isHidden = true
        label.font = UIFont(name: "Georgia-Italic", size: 16)
        return label
    }()
        
    let priorityLabel: UILabel = {
        let label = UILabel()
        label.text = "Приоритет:"
        label.textColor = .black
        label.font = UIFont(name: "HelveticaNeue-Italic", size: 18)
        label.layer.shadowOpacity = 1
        label.layer.shadowRadius = 5.0
        label.layer.shadowOffset = CGSize(width: 6, height: 4)
        label.layer.shadowColor = #colorLiteral(red: 0.004984250292, green: 0.2071827948, blue: 0.01191163901, alpha: 0.749474936)
        return label
    }()
    
    let priorityTaskLabel: UILabel = {
        let label = UILabel()
        label.layer.shadowRadius = 7.0
        label.layer.shadowOpacity = 1
        label.layer.shadowOffset = CGSize(width: 2, height: 2)
        label.font = UIFont(name: "TimesNewRomanPSMT", size: 20)
        return label
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.text = "Сделать до:"
        label.font = UIFont(name: "HelveticaNeue-Italic", size: 18)
        label.layer.shadowOpacity = 1
        label.textColor = .black
        label.layer.shadowRadius = 5.0
        label.layer.shadowOffset = CGSize(width: 6, height: 4)
        label.layer.shadowColor = #colorLiteral(red: 0.004984250292, green: 0.2071827948, blue: 0.01191163901, alpha: 0.749474936)
        return label
    }()
    
    let dateTaskLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Georgia-Italic", size: 18)
        label.textColor = #colorLiteral(red: 0.8374180198, green: 0.8374378085, blue: 0.8374271393, alpha: 1)
        return label
    }()
    
    let changeButton: UIButton = {
        let button = UIButton()
        button.setTitle("Изменить", for: .normal)
        button.backgroundColor = .green
        button.layer.cornerRadius = 15
        button.setTitleColor(.darkGray, for: .normal)
        button.setTitleColor(.darkGray, for: .highlighted)
        button.addTarget(self, action: #selector(changeButtonDidTapped), for: .touchUpInside)
        return button
    }()
    
    let deleteButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 26
        button.setTitle("🗑", for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.913997829, green: 0, blue: 0.2220681012, alpha: 1)
        button.addTarget(self, action: #selector(deleteButtonDidTapped), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        detailTask = UDStorage.shared.tasks[taskIndexPath.section]
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [#colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1).cgColor, UIColor.white.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 1)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0)
        view.layer.insertSublayer(gradientLayer, at: 0)
                        
        title = "Подробно"
        navigationItem.largeTitleDisplayMode = .never
        navigationController?.navigationBar.standardAppearance.backgroundEffect = nil
        
        nameStackView = setNameStackView()
        priorityAndDateStackView = setPriorityAndDateStackView()
        setValues()
        descriptionScrollView.addSubview(descriptionTaskLabel)
        view.addSubview(nameStackView)
        view.addSubview(priorityAndDateStackView)
        view.addSubview(descriptionScrollView)
        view.addSubview(descriptionLabel)
        view.addSubview(changeButton)
        view.addSubview(deleteButton)
        setConstraints()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.standardAppearance.backgroundEffect = UIBlurEffect(style: .systemUltraThinMaterialLight)
    }
}
