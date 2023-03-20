//
//  TimerView.swift
//  Fitness
//
//  Created by KODDER on 21.12.2022.
//

import UIKit

protocol NextSetTimerProtocol: AnyObject {
    func nextSetTimerTapped()
    func editingTimerTapped()
}

class TimerParametersView: UIView {
    
    let mainLabel = UILabel(text: "", font: .robotoMedium24(), textColor: .specialGray)
    
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
    
    let numberOfSetLabel = UILabel(text: "",
                                           font: .robotoMedium24(),
                                           textColor: .specialGray)
    
    private let timeOfSetLabel = UILabel(text: "Time of set",
                                    font: .robotoMedium18(),
                                    textColor: .specialGray)
    
    let numberTimeOfSetLabel = UILabel(text: "",
                                            font: .robotoMedium24(),
                                            textColor: .specialGray)
    
    private var setsStackView = UIStackView()
    private var timeOfSetStackView = UIStackView()
    
    weak var cellNextSetTimerDelegate: NextSetTimerProtocol?
    
    lazy var editingButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "Editing")?.withRenderingMode(.alwaysOriginal), for: .normal)
        button.setTitle("Editing", for: .normal)
        button.titleLabel?.tintColor = .specialGray
        button.titleLabel?.font = UIFont.robotoMedium16()
        button.addTarget(self, action: #selector(editingButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var nextSetButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .specialDarkYellow
        button.layer.cornerRadius = 10
        button.titleLabel?.font = .robotoBold16()
        button.titleLabel?.tintColor = .specialDarkGreen
        button.setTitle("NEXT SET", for: .normal)
        button.addTarget(self, action: #selector(nextSetsButtonTapped), for: .touchUpInside)
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
        
        timeOfSetStackView = UIStackView(arrangedSubviews: [timeOfSetLabel, numberTimeOfSetLabel],
                                    axis: .horizontal,
                                    spacing: 15)
        addSubview(timeOfSetStackView)
        addSubview(lineTwoImageView)
        addSubview(editingButton)
        addSubview(nextSetButton)
    }
    
    @objc private func editingButtonTapped() {
        cellNextSetTimerDelegate?.editingTimerTapped()
    }
    
    @objc private func nextSetsButtonTapped() {
        cellNextSetTimerDelegate?.nextSetTimerTapped()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension TimerParametersView {
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
            
            timeOfSetStackView.topAnchor.constraint(equalTo: lineOneImageView.bottomAnchor, constant: 25),
            timeOfSetStackView.leftAnchor.constraint(equalTo: leftAnchor, constant: 15),
            timeOfSetStackView.rightAnchor.constraint(equalTo: rightAnchor, constant: -15),
            
            lineTwoImageView.topAnchor.constraint(equalTo: timeOfSetStackView.bottomAnchor, constant: 1),
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
