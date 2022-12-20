//
//  DetailsView.swift
//  Fitness
//
//  Created by KODDER on 20.12.2022.
//

import UIKit

class DetailsView: UIView {
    
    private let mainLabel = UILabel(text: "Biceps", font: .robotoMedium24(), textColor: .specialGray)
    
    private let lineOneImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Line")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let lineTwoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Line")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let setsLabel = UILabel(text: "Sets",
                                    font: .robotoMedium18(),
                                    textColor: .specialGray)
    
    private let numberOfSetLabel = UILabel(text: "1/4",
                                           font: .robotoMedium24(),
                                           textColor: .specialGray)
    
    private let repsLabel = UILabel(text: "Reps",
                                    font: .robotoMedium18(),
                                    textColor: .specialGray)
    
    private let numberOfRepsLabel = UILabel(text: "20",
                                            font: .robotoMedium24(),
                                            textColor: .specialGray)
    
    private var setsStackView = UIStackView()
    private var repsStackView = UIStackView()
    
    private let editingButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "Editing")?.withRenderingMode(.alwaysOriginal), for: .normal)
        button.setTitle("Editing", for: .normal)
        button.titleLabel?.tintColor = .specialGray
        button.titleLabel?.font = UIFont.robotoMedium16()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var nextSetButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .specialDarkYellow
        button.layer.cornerRadius = 10
        button.titleLabel?.font = .robotoBold16()
        button.titleLabel?.tintColor = .specialDarkGreen
        button.setTitle("NEXT SET", for: .normal)
        button.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        setConstraints()
    }
    
    private func setupView() {
        backgroundColor = .specialBrown
        layer.cornerRadius = 10
        translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(mainLabel)
        
        setsStackView = UIStackView(arrangedSubviews: [setsLabel, numberOfSetLabel],
                                    axis: .horizontal,
                                    spacing: 10)
        addSubview(setsStackView)
        addSubview(lineOneImageView)
        
        repsStackView = UIStackView(arrangedSubviews: [repsLabel, numberOfRepsLabel],
                                    axis: .horizontal,
                                    spacing: 10)
        addSubview(repsStackView)
        addSubview(lineTwoImageView)
        addSubview(editingButton)
        addSubview(nextSetButton)
    }
    
    @objc private func nextButtonTapped() {
        print("Next set")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension DetailsView {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            mainLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            mainLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            setsStackView.topAnchor.constraint(equalTo: mainLabel.bottomAnchor, constant: 20),
            setsStackView.leftAnchor.constraint(equalTo: leftAnchor, constant: 15),
            setsStackView.rightAnchor.constraint(equalTo: rightAnchor, constant: -15),
            
            lineOneImageView.topAnchor.constraint(equalTo: setsStackView.bottomAnchor, constant: 1),
            lineOneImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 15),
            lineOneImageView.rightAnchor.constraint(equalTo: rightAnchor, constant: -15),
            
            repsStackView.topAnchor.constraint(equalTo: lineOneImageView.bottomAnchor, constant: 25),
            repsStackView.leftAnchor.constraint(equalTo: leftAnchor, constant: 15),
            repsStackView.rightAnchor.constraint(equalTo: rightAnchor, constant: -15),
            
            lineTwoImageView.topAnchor.constraint(equalTo: repsStackView.bottomAnchor, constant: 1),
            lineTwoImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 15),
            lineTwoImageView.rightAnchor.constraint(equalTo: rightAnchor, constant: -15),
            
            editingButton.topAnchor.constraint(equalTo: lineTwoImageView.bottomAnchor, constant: 20),
            editingButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -15),
            
            nextSetButton.topAnchor.constraint(equalTo: editingButton.bottomAnchor, constant: 20),
            nextSetButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            nextSetButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),
            nextSetButton.heightAnchor.constraint(equalToConstant: 45)
        ])
    }
}
