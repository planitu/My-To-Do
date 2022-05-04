//
//  MainVC.swift
//  My ToDo
//
//  Created by Максим on 20.04.2022.
//

import UIKit
import UserNotifications

class MainVC: UIViewController {

    let tasksTableView: UITableView = {
        let tableView = UITableView(frame: CGRect(), style: .insetGrouped)
        tableView.sectionFooterHeight = 5
        tableView.sectionHeaderHeight = 5
        tableView.register(TaskTVCell.self, forCellReuseIdentifier: "reuseTaskCell")
        return tableView
    }()
    var tableShowFlag = false
    
    let newTaskButton: UIButton = {
       let button = UIButton()
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.backgroundColor = .green
        button.tintColor = .darkGray
        button.layer.cornerRadius = 25
        button.layer.shadowColor = UIColor.gray.cgColor
        button.layer.shadowOpacity = 0.7
        button.layer.shadowRadius = 8
        button.layer.shadowOffset = CGSize(width: 0, height: 0.5)
        button.addTarget(self, action: #selector(newTaskButtonDidTapped), for: .touchUpInside)
        return button
    }()
        
    let interactiveTransition = BubbleInteractiveTransition()
    let transition = BubbleTransition()
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [UIColor.white.cgColor, #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1).cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        view.layer.insertSublayer(gradientLayer, at: 0)
        
        navigationItem.title = "Мои дела"
        navigationItem.largeTitleDisplayMode = .always
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Архив", style: .plain, target: self, action: #selector(showArchive))
                
        tasksTableView.backgroundColor = .clear
        tasksTableView.delegate = self
        tasksTableView.dataSource = self

        view.addSubview(tasksTableView)
        view.addSubview(newTaskButton)
        setMyConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tasksTableView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
                
        if !tableShowFlag {
            animatedTableViewShow()
            tableShowFlag = true
        }
        
        newTaskButton.rotate(duration: 0.5, turns: 6)
        
        if UDStorage.shared.tasks.count == 0 {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                self.newTaskButton.shake()
                Haptic.impact(.rigid).generate() }
        }
    }
    
    @objc func newTaskButtonDidTapped() {

        let controller = NewTaskVC()
        controller.transitioningDelegate = self
        controller.modalPresentationStyle = .custom
        controller.modalPresentationCapturesStatusBarAppearance = true
        Haptic.impact(.soft).generate()
        present(controller, animated: true, completion: nil)
    }
    
    @objc func showArchive() {
        Haptic.impact(.medium).generate()
        UDStorage.shared.saveTasks()
        UDStorage.shared.changeTasksTypeFlag()
        UDStorage.shared.changeTasksType()
        tasksTableView.reloadData()
        animatedTableViewShow()
        if UDStorage.shared.isActiveTasksNow {
            navigationItem.title = "Мои дела"
            navigationItem.leftBarButtonItem?.tintColor = UIColor.black
        } else {
            navigationItem.title = "Выполнено"
            navigationItem.leftBarButtonItem?.tintColor = UIColor.purple
        }
        newTaskButtonAnimateHideAndShow()
    }
    
    func newTaskButtonAnimateHideAndShow() {
        
        if UDStorage.shared.isActiveTasksNow {
            self.newTaskButton.isEnabled = true
            UIView.animate(withDuration: 0.2) {
                self.newTaskButton.alpha = 1
                self.newTaskButton.backgroundColor = .green
            }
        } else {
            self.newTaskButton.isEnabled = false
            UIView.animate(withDuration: 0.2) {
                self.newTaskButton.backgroundColor = .white
                self.newTaskButton.alpha = 0
            }
        }
    }
    
    private func setMyConstraints() {
        
        tasksTableView.translatesAutoresizingMaskIntoConstraints = false
        newTaskButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            tasksTableView.topAnchor.constraint(equalTo: view.topAnchor),
            tasksTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tasksTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tasksTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            newTaskButton.heightAnchor.constraint(equalToConstant: 52),
            newTaskButton.widthAnchor.constraint(equalToConstant: 52),
            newTaskButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -18),
            newTaskButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -32)
        ])
    }
}
