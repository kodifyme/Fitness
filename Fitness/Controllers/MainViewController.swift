//
//  MainViewController.swift
//  Fitness
//
//  Created by KODDER on 29.11.2022.
//

import UIKit

class MainViewController: UIViewController {

    private let userPhotoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .gray
        imageView.layer.borderWidth = 5
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let userNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Your name"
        label.minimumScaleFactor = 0.5
        label.font = .robotoMedium24()
        label.textColor = .specialGray
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var addWorkoutButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.cornerRadius = 10
        button.backgroundColor = .specialYellow
        button.setTitle("Add workout", for: .normal)
        button.tintColor = .specialDarkGreen
        button.setImage(UIImage(named: "addWorkout"), for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: 0,
                                              left: 20,
                                              bottom: 15,
                                              right: 0)
        button.titleEdgeInsets = UIEdgeInsets(top: 50,
                                              left: -40,
                                              bottom: 0,
                                              right: 0)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 10)
        button.addTarget(self, action: #selector(addWorkoutButtonTapped), for: .touchUpInside)
        button.addShadowOnView()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let calendarView = CalendarView()
    private let weatherView = WeatherView()
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        userPhotoImageView.layer.cornerRadius = userPhotoImageView.frame.width / 2
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setConstraints()
    }
    
    private func setupView() {
        view.backgroundColor = .specialBackground
        
        view.addSubview(calendarView)
        view.addSubview(userPhotoImageView)
        view.addSubview(userNameLabel)
        view.addSubview(addWorkoutButton)
        view.addSubview(weatherView)
    }
                                                                                                                            
    @objc private func addWorkoutButtonTapped() {
        print("tap")
    }
}

extension MainViewController {
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            userPhotoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            userPhotoImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            userPhotoImageView.heightAnchor.constraint(equalToConstant: 100),
            userPhotoImageView.widthAnchor.constraint(equalToConstant: 100),
            
            calendarView.topAnchor.constraint(equalTo: userPhotoImageView.centerYAnchor),
            calendarView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            calendarView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            calendarView.heightAnchor.constraint(equalToConstant: 70),
            
            userNameLabel.leadingAnchor.constraint(equalTo: userPhotoImageView.trailingAnchor, constant: 5),
            userNameLabel.bottomAnchor.constraint(equalTo: calendarView.topAnchor, constant: 0),
            userNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            
            addWorkoutButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            addWorkoutButton.topAnchor.constraint(equalTo: calendarView.bottomAnchor, constant: 5),
            addWorkoutButton.heightAnchor.constraint(equalToConstant: 80),
            addWorkoutButton.widthAnchor.constraint(equalToConstant: 80),
            
            weatherView.topAnchor.constraint(equalTo: calendarView.bottomAnchor, constant: 5),
            weatherView.leadingAnchor.constraint(equalTo: addWorkoutButton.trailingAnchor, constant: 5),
            weatherView.heightAnchor.constraint(equalToConstant: 80),
            weatherView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10)
        ])
    }
}
