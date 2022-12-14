//
//  RepsOrTimerView.swift
//  Fitness
//
//  Created by KODDER on 14.12.2022.
//

import UIKit

class RepsOrTimerView: UIView {
    
    private lazy var setsSlider: UISlider = {
        let slider = UISlider()
        slider.minimumValue = 0
        slider.maximumValue = 10
        slider.maximumTrackTintColor = .specialLightBrown
        slider.minimumTrackTintColor = .specialGreen
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.addTarget(self, action: #selector(setsSliderChanged), for: .valueChanged)
        return slider
    }()
    
    private lazy var  repsSlider: UISlider = {
        let slider = UISlider()
        slider.minimumValue = 0
        slider.maximumValue = 50
        slider.maximumTrackTintColor = .specialLightBrown
        slider.minimumTrackTintColor = .specialGreen
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.addTarget(self, action: #selector(repsSliderChanged), for: .valueChanged)
        return slider
    }()
    
    private lazy var  timerSlider: UISlider = {
        let slider = UISlider()
        slider.minimumValue = 0
        slider.maximumValue = 600
        slider.maximumTrackTintColor = .specialLightBrown
        slider.minimumTrackTintColor = .specialGreen
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.addTarget(self, action: #selector(timerSliderChanged), for: .valueChanged)
        return slider
    }()
    
    private let setsLabel = UILabel(text: "Sets",
                                    font: .robotoMedium18(),
                                    textColor: .specialGray)
    
    private let numberOfSetLabel = UILabel(text: "0",
                                           font: .robotoMedium24(),
                                           textColor: .specialGray)
    
    private let repsLabel = UILabel(text: "Reps",
                                    font: .robotoMedium18(),
                                    textColor: .specialGray)
    
    private let numberOfRepsLabel = UILabel(text: "0",
                                            font: .robotoMedium24(),
                                            textColor: .specialGray)
    
    private let timerLabel = UILabel(text: "Timer",
                                     font: .robotoMedium18(),
                                     textColor: .specialGray)
    
    
    private let numberOfTimerLabel = UILabel(text: "0 min",
                                             font: .robotoMedium24(),
                                             textColor: .specialGray)
    
    private let repeatOrTimerLabel = UILabel(text: "Choose repeat or timer")
    
    private var setsStackView = UIStackView()
    private var repsStackView = UIStackView()
    private var timerStackView = UIStackView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        backgroundColor = .specialBrown
        layer.cornerRadius = 10
        translatesAutoresizingMaskIntoConstraints = false
        
        setsStackView = UIStackView(arrangedSubviews: [setsLabel, numberOfSetLabel])
        setsStackView.axis = .horizontal
        setsStackView.spacing = 10
        setsStackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(setsStackView)
        addSubview(setsSlider)
        addSubview(repeatOrTimerLabel)
        
        repsStackView = UIStackView(arrangedSubviews: [repsLabel, numberOfRepsLabel])
        repsStackView.axis = .horizontal
        repsStackView.spacing = 10
        repsStackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(repsStackView)
        addSubview(repsSlider)
        
        timerStackView = UIStackView(arrangedSubviews: [timerLabel, numberOfTimerLabel])
        timerStackView.axis = .horizontal
        timerStackView.spacing = 10
        timerStackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(timerStackView)
        addSubview(timerSlider)
    }
    
    @objc private func setsSliderChanged() {
        print(setsSlider.value)
    }
    
    @objc private func repsSliderChanged() {
        print(repsSlider.value)
    }
    
    @objc private func timerSliderChanged() {
        print(timerSlider.value)
    }
}

extension RepsOrTimerView {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            setsStackView.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            setsStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            setsStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
        
            setsSlider.topAnchor.constraint(equalTo: setsStackView.bottomAnchor, constant: 10),
            setsSlider.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            setsSlider.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
        
            repeatOrTimerLabel.topAnchor.constraint(equalTo: setsSlider.bottomAnchor, constant: 15),
            repeatOrTimerLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
        
            repsStackView.topAnchor.constraint(equalTo: repeatOrTimerLabel.bottomAnchor, constant: 20),
            repsStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            repsStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
        
            repsSlider.topAnchor.constraint(equalTo: repsStackView.bottomAnchor, constant: 10),
            repsSlider.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            repsSlider.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
        
            timerStackView.topAnchor.constraint(equalTo: repsSlider.bottomAnchor, constant: 20),
            timerStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            timerStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
        
            timerSlider.topAnchor.constraint(equalTo: timerStackView.bottomAnchor, constant: 10),
            timerSlider.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            timerSlider.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15)
        ])
    }
}



