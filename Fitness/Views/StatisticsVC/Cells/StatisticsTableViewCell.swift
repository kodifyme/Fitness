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
    
    private var stackView = UIStackView()
    
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
        
        stackView = UIStackView(arrangedSubviews: [beforeLabel, nowLabel])
        stackView.axis = .horizontal // check docu
        stackView.spacing = 10   // check docu
        stackView.translatesAutoresizingMaskIntoConstraints = false // change
        addSubview(stackView)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            
            differenceLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            differenceLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            differenceLabel.widthAnchor.constraint(equalToConstant: 50),
        
            nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            nameLabel.trailingAnchor.constraint(equalTo: differenceLabel.leadingAnchor, constant: -10),
        
            stackView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 0),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16)
        ])
    }
}
