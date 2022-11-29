//
//  WeatherView.swift
//  Fitness
//
//  Created by KODDER on 29.11.2022.
//

import UIKit

class WeatherView: UIView {
    
    private let mainLabel: UILabel = {
        let label = UILabel()
        label.text = "Солнечно"
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let secondLabel: UILabel = {
        let label = UILabel()
        label.text = "Хорошая погода, чтобы позаниматься на улице"
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 2
        label.textColor = #colorLiteral(red: 0.7607843137, green: 0.7607843137, blue: 0.7607843137, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let sunImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "sun")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        backgroundColor = #colorLiteral(red: 0.9764705882, green: 0.9764705882, blue: 0.9764705882, alpha: 1)
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 10
        
        addSubview(mainLabel)
        addSubview(secondLabel)
        addSubview(sunImageView)
    }
}

extension WeatherView {
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            mainLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            mainLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            
            secondLabel.topAnchor.constraint(equalTo: mainLabel.bottomAnchor, constant: 5),
            secondLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            secondLabel.trailingAnchor.constraint(equalTo: sunImageView.leadingAnchor, constant: -50),
            
            sunImageView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            sunImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            sunImageView.widthAnchor.constraint(equalToConstant: 60)
        ])
    }
}
