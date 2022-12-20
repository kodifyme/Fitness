//
//  RepsWorkoutViewController.swift
//  Fitness
//
//  Created by KODDER on 20.12.2022.
//

import UIKit

class RepsWorkoutViewController: UIViewController {
    
    private let mainLabel = UILabel(text: "START WORKOUT", font: .robotoMedium24(), textColor: .specialGray)
    
    private lazy var closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "closeButton")!.withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let humanImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "WorkoutHuman")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let detailsLabel = UILabel(text: "Details")
    
    private let detailsView = DetailsView()
    
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
        view.addSubview(humanImageView)
        view.addSubview(detailsLabel)
        view.addSubview(detailsView)
        view.addSubview(finishButton)
    }
    
    @objc private func closeButtonTapped() {
        dismiss(animated: true)
    }
    
    @objc private func finishButtonTapped() {
        print("Finish")
    }
}

extension RepsWorkoutViewController {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            mainLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            mainLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            closeButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            closeButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            
            humanImageView.topAnchor.constraint(equalTo: mainLabel.bottomAnchor, constant: 30),
            humanImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            detailsLabel.topAnchor.constraint(equalTo: humanImageView.bottomAnchor, constant: 15),
            detailsLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 25),
            
            detailsView.topAnchor.constraint(equalTo: detailsLabel.bottomAnchor, constant: 3),
            detailsView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            detailsView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            detailsView.heightAnchor.constraint(equalToConstant: 270),
            
            finishButton.topAnchor.constraint(equalTo: detailsView.bottomAnchor, constant: 15),
            finishButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            finishButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            finishButton.heightAnchor.constraint(equalToConstant: 55)
        ])
    }
}
