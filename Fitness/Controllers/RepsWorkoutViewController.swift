//
//  RepsWorkoutViewController.swift
//  Fitness
//
//  Created by KODDER on 20.12.2022.
//

import UIKit

class RepsWorkoutViewController: UIViewController {
    
    private let mainLabel = UILabel(text: "START WORKOUT", font: .robotoMedium24(), textColor: .specialGray)
    
    private lazy var closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "closeButton")!.withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let humanImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "WorkoutHuman")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let detailsLabel = UILabel(text: "Details")
    
    private let workoutParametersView = WorkoutParametersView()
    
    private lazy var finishButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .specialGreen
        button.setTitle("FINISH", for: .normal)
        button.titleLabel?.tintColor = .white
        button.layer.cornerRadius = 10
        button.titleLabel?.font = .robotoBold16()
        button.addTarget(self, action: #selector(finishButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var workoutModel = WorkoutModel()
    let customAlert = CustomAlert()
    
    private var numberOfSet = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setConstraints()
        setWorkoutParameters()
        
        workoutParametersView.cellNextSetDelegate = self
    }
    
    private func setupView() {
        view.backgroundColor = .specialBackground
        
        view.addSubview(mainLabel)
        view.addSubview(closeButton)
        view.addSubview(humanImageView)
        view.addSubview(detailsLabel)
        view.addSubview(workoutParametersView)
        view.addSubview(finishButton)
    }
    
    @objc private func closeButtonTapped() {
        dismiss(animated: true)
    }
    
    @objc private func finishButtonTapped() {
        print("Finish")
    }
    
    private func setWorkoutParameters() {
        workoutParametersView.mainLabel.text = workoutModel.workoutName
        workoutParametersView.numberOfSetsLabel.text = "\(numberOfSet)/\(workoutModel.workoutSets)"
        workoutParametersView.numberOfRepsLabel.text = "\(workoutModel.workoutReps)"
    }
}

//MARK: - NextSetProtocol
extension RepsWorkoutViewController: NextSetProtocol {
    func nextSetTapped() {
        if numberOfSet < workoutModel.workoutSets {
            numberOfSet += 1
            workoutParametersView.numberOfSetsLabel.text = "\(numberOfSet)/\(workoutModel.workoutSets)"
        } else {
            alertOk(title: "Error", message: "Finish your workout")
        }
    }
    
    func editingTapped() {
        customAlert.alertCustom(viewController: self,
                                repsOrTimer: "Reps", completion: { _,_ in 
            
        })
    }
}

extension RepsWorkoutViewController {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            mainLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            mainLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            closeButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            closeButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            
            humanImageView.topAnchor.constraint(equalTo: mainLabel.bottomAnchor, constant: 30),
            humanImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            detailsLabel.topAnchor.constraint(equalTo: humanImageView.bottomAnchor, constant: 15),
            detailsLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 25),
            
            workoutParametersView.topAnchor.constraint(equalTo: detailsLabel.bottomAnchor, constant: 3),
            workoutParametersView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            workoutParametersView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            workoutParametersView.heightAnchor.constraint(equalToConstant: 270),
            
            finishButton.topAnchor.constraint(equalTo: workoutParametersView.bottomAnchor, constant: 15),
            finishButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            finishButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            finishButton.heightAnchor.constraint(equalToConstant: 55)
        ])
    }
}
