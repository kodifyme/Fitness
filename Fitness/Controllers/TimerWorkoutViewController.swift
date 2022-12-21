//
//  TimerWorkoutViewController.swift
//  Fitness
//
//  Created by KODDER on 21.12.2022.
//

import UIKit

class TimerWorkoutViewController: UIViewController {
    
    private let mainLabel = UILabel(text: "START WORKOUT", font: .robotoMedium24(), textColor: .specialGray)
    
    private lazy var closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "closeButton")!.withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let circularImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "CircularBar")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let detailsLabel = UILabel(text: "Details")
    
    private let timerView = TimerView()
    
    private lazy var finishButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .specialGreen
        button.setTitle("FINISH", for: .normal)
        button.titleLabel?.tintColor = .white
        button.layer.cornerRadius = 10
        button.titleLabel?.font = .robotoBold16()
        button.addTarget(self, action: #selector(finishButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setConstraints()
    }
    
    private func setupView() {
        view.backgroundColor = .specialBackground
        
        view.addSubview(mainLabel)
        view.addSubview(closeButton)
        view.addSubview(circularImageView)
        view.addSubview(detailsLabel)
        view.addSubview(timerView)
        view.addSubview(finishButton)
    }
    
    @objc private func closeButtonTapped() {
        dismiss(animated: true)
    }
    
    @objc private func finishButtonTapped() {
        print("Finish")
    }
}

extension TimerWorkoutViewController {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            mainLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            mainLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            closeButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            closeButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            
            circularImageView.topAnchor.constraint(equalTo: mainLabel.bottomAnchor, constant: 30),
            circularImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            detailsLabel.topAnchor.constraint(equalTo: circularImageView.bottomAnchor, constant: 15),
            detailsLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 25),
            
            timerView.topAnchor.constraint(equalTo: detailsLabel.bottomAnchor, constant: 3),
            timerView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            timerView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            timerView.heightAnchor.constraint(equalToConstant: 270),
            
            finishButton.topAnchor.constraint(equalTo: timerView.bottomAnchor, constant: 15),
            finishButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            finishButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            finishButton.heightAnchor.constraint(equalToConstant: 55)
        ])
    }
}
