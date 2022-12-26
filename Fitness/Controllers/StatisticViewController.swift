//
//  StatisticViewController.swift
//  Fitness
//
//  Created by KODDER on 05.12.2022.
//

import UIKit
import RealmSwift

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
    
    private let localRealm = try! Realm()
    private var workoutArray: Results<WorkoutModel>!
    
    private var differenceArray = [DifferenceWorkout]()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        differenceArray = [DifferenceWorkout]()
        setStartScreen()
        statisticsTableView.reloadData()
    }
    
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
        let dateToday = Date().localDate()
        differenceArray = [DifferenceWorkout]()
        
        if segmentControlTop.selectedSegmentIndex == 0 {
            let dateStart = dateToday.offsetDays(days: 7)
            getDifferenceModel(dateStart: dateStart)
        } else {
            let dateStart = dateToday.offsetMonth(month: 1)
            getDifferenceModel(dateStart: dateStart)
        }
        statisticsTableView.reloadData()
    }
    
    // Get unique names
    private func getWorkoutsName() -> [String] {
        var nameArray = [String]()
        workoutArray = localRealm.objects(WorkoutModel.self)
        
        for workoutModel in workoutArray {
            if !nameArray.contains(workoutModel.workoutName) {
                nameArray.append(workoutModel.workoutName)
            }
        }
        return nameArray
    }
    
    private func getDifferenceModel(dateStart: Date) {
        let dateEnd = Date().localDate()
        let nameArray = getWorkoutsName()
        
        for name in nameArray {
            let predicateDifference = NSPredicate(format: "workoutName = '\(name)' AND workoutDate BETWEEN %@", [dateStart, dateEnd])
            workoutArray = localRealm.objects(WorkoutModel.self).filter(predicateDifference).sorted(byKeyPath: "workoutDate")
            
            guard let last = workoutArray.last?.workoutReps,
                  let first = workoutArray.first?.workoutReps else { return }
            
            let differenceWorkout = DifferenceWorkout(name: name, lastReps: last, firstReps: first)
            differenceArray.append(differenceWorkout)
        }
    }
    
    private func setStartScreen() {
        let dateToday = Date().localDate()
        getDifferenceModel(dateStart: dateToday.offsetDays(days: 7))
        statisticsTableView.reloadData()
    }
}

extension StatisticViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        differenceArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: StatisticsTableViewCell.identifier, for: indexPath) as? StatisticsTableViewCell else {
            return UITableViewCell()
        }
        let differenceModel = differenceArray[indexPath.row]
        cell.cellConfigure(differenceWorkout: differenceModel)
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
