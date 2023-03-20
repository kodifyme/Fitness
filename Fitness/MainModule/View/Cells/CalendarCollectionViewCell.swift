//
//  CalendarCollectionViewCell.swift
//  Fitness
//
//  Created by KODDER on 01.12.2022.
//

import UIKit

class CalendarCollectionViewCell: UICollectionViewCell {
    
    private let dayOfWeekLabel: UILabel = {
        let label = UILabel()
        label.text = "We"
        label.font = .robotoBold16()
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let numberOfDayLabel: UILabel = {
        let label = UILabel()
        label.text = "07"
        label.font = .robotoBold20()
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override var isSelected: Bool {
        didSet {
            if self.isSelected {
                backgroundColor = .specialYellow
                layer.cornerRadius = 10
                dayOfWeekLabel.textColor = .specialBlack
                numberOfDayLabel.textColor = .specialDarkGreen
            } else {
                backgroundColor = .none
                dayOfWeekLabel.textColor = .white
                numberOfDayLabel.textColor = .white
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubview(dayOfWeekLabel)
        addSubview(numberOfDayLabel)
    }
    
    private func cellConfigure(numberOfDay: String, dayOfWeek: String) {
        numberOfDayLabel.text = numberOfDay
        dayOfWeekLabel.text = dayOfWeek
    }
    
    public func dateForCell(numberOfDay: String, dayOfWeek: String) {
        cellConfigure(numberOfDay: numberOfDay, dayOfWeek: dayOfWeek)
    }
}

extension CalendarCollectionViewCell {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            dayOfWeekLabel.topAnchor.constraint(equalTo: topAnchor, constant: 7),
            dayOfWeekLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            numberOfDayLabel.topAnchor.constraint(equalTo: dayOfWeekLabel.bottomAnchor, constant: 5),
            numberOfDayLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
}


















