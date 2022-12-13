//
//  StatisticViewController.swift
//  Fitness
//
//  Created by KODDER on 05.12.2022.
//

import UIKit


class StatisticViewController: UIViewController {
    
    private let mainLabel = UILabel(text: "STATISTIC", font: .robotoMedium24(), textColor: .specialGray)
    
    private lazy var segmentControlTop: UISegmentedControl = {
        let segmentControl = UISegmentedControl(items: ["Неделя", "Месяц"])
        segmentControl.backgroundColor = .specialGreen
        segmentControl.selectedSegmentTintColor = .specialDarkYellow
        segmentControl.selectedSegmentIndex = 0
        segmentControl.addTarget(self, action: #selector(segmentedChange), for: .valueChanged)
        segmentControl.translatesAutoresizingMaskIntoConstraints = false
        return segmentControl
    }()
    
    private let exercisesLabel = UILabel(text: "Exercises")
    
    private let statisticsTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.register(StatisticsTableViewCell.self, forCellReuseIdentifier: StatisticsTableViewCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setConstraints()
        
        statisticsTableView.delegate = self
        statisticsTableView.dataSource = self
    }
    
    private func setupView() {
        view.backgroundColor = .specialBackground
        
        view.addSubview(mainLabel)
        view.addSubview(segmentControlTop)
        view.addSubview(exercisesLabel)
        view.addSubview(statisticsTableView)
    }
    
    @objc private func segmentedChange() {
        segmentControlTop.selectedSegmentIndex == 0 ? print("Неделя") : print("Месяц")
    }
}

extension StatisticViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: StatisticsTableViewCell.identifier, for: indexPath) as? StatisticsTableViewCell else {
            return UITableViewCell()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        55
    }
}

extension StatisticViewController {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            mainLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            mainLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            segmentControlTop.topAnchor.constraint(equalTo: mainLabel.bottomAnchor, constant: 20),
            segmentControlTop.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            segmentControlTop.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            segmentControlTop.heightAnchor.constraint(equalToConstant: 32),
            
            exercisesLabel.topAnchor.constraint(equalTo: segmentControlTop.bottomAnchor, constant: 10),
            exercisesLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            statisticsTableView.topAnchor.constraint(equalTo: exercisesLabel.bottomAnchor, constant: 5),
            statisticsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            statisticsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            statisticsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
    }
}
