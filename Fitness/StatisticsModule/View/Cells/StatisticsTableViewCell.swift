//
//  StatisticsTableViewCell.swift
//  Fitness
//
//  Created by KODDER on 12.12.2022.
//

import UIKit

class StatisticsTableViewCell: UITableViewCell {
    
    static let identifier = "StatisticsTableViewCell"
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Biceps"
        label.font = .robotoMedium24()
        label.textColor = .specialGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let beforeLabel = UILabel(text: "Before: 18")
    private let nowLabel = UILabel(text: "Now: 20")
    
    let differenceLabel: UILabel = {
        let label = UILabel()
        label.text = "+2"
        label.font = .robotoMedium24()
        label.textColor = .specialGreen
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var underStackView = UIStackView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupView()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        backgroundColor = .clear
        selectionStyle = .none
        
        addSubview(differenceLabel)
        addSubview(nameLabel)
        
        underStackView = UIStackView(arrangedSubviews: [beforeLabel, nowLabel],
                                     axis: .horizontal,
                                     spacing: 10)
        addSubview(underStackView)
    }
    
    func cellConfigure(differenceWorkout: DifferenceWorkout) {
        nameLabel.text = differenceWorkout.name
        beforeLabel.text = "Before: \(differenceWorkout.firstReps)"
        nowLabel.text = "Now: \(differenceWorkout.lastReps)"
        
        let difference = differenceWorkout.lastReps - differenceWorkout.firstReps
        differenceLabel.text = "\(difference)"
        
        switch difference {
            case ..<0: differenceLabel.textColor = .red
            case 1...: differenceLabel.textColor = .specialGreen
            default: differenceLabel.textColor = .specialDarkYellow
        }
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            
            differenceLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            differenceLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            differenceLabel.widthAnchor.constraint(equalToConstant: 50),
            
            nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            nameLabel.trailingAnchor.constraint(equalTo: differenceLabel.leadingAnchor, constant: -10),
            
            underStackView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 0),
            underStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16)
        ])
    }
}
