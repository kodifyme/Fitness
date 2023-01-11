//
//  WorkoutCollectionViewCell.swift
//  Fitness
//
//  Created by KODDER on 11.01.2023.
//

import UIKit

class WorkoutCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "idWorkoutCollectionViewCell"
    
    private let nameWorkoutLabel = UILabel(text: "PUSH UPS", font: .robotoBold20(), textColor: .white)
    
    private let workoutImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "imageCell")?.withRenderingMode(.alwaysOriginal)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let numberLabel = UILabel(text: "180", font: UIFont(name: "Roboto-Bold", size: 50), textColor: .white)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        backgroundColor = .specialGreen
        layer.cornerRadius = 20
        
        addSubview(nameWorkoutLabel)
        addSubview(workoutImageView)
        addSubview(numberLabel)
    }
}


extension WorkoutCollectionViewCell {
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            nameWorkoutLabel.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            nameWorkoutLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            workoutImageView.topAnchor.constraint(equalTo: nameWorkoutLabel.bottomAnchor, constant: 7),
            workoutImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
            workoutImageView.heightAnchor.constraint(equalToConstant: 60),
            
            numberLabel.centerYAnchor.constraint(equalTo: workoutImageView.centerYAnchor),
            numberLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -10)
        ])
    }
}
