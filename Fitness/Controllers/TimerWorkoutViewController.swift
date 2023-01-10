//
//  TimerWorkoutViewController.swift
//  Fitness
//
//  Created by KODDER on 21.12.2022.
//

import UIKit

class TimerWorkoutViewController: UIViewController {
    
    private let mainLabel = UILabel(text: "START WORKOUT", font: .robotoMedium24(), textColor: .specialGray)
    
    private lazy var closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "closeButton")!.withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let circularImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "CircularBar")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let timerLabel: UILabel = {
       let label = UILabel()
        label.text = "1"
        label.textColor = .specialGray
        label.font = .robotoBold48()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let detailsLabel = UILabel(text: "Details")
    
    private let timerParametersView = TimerParametersView()
    
    var workoutModel = WorkoutModel()
    private let customAlert = CustomAlert()
    
    private var durationTimer = 0
    private var numberOfSet = 0
    private var shapeLayer = CAShapeLayer()
    private var timer = Timer()
    
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
    
    override func viewDidLayoutSubviews() {
        animationCircular()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setConstraints()
        addTaps()
        setWorkoutsParameters()
        
        timerParametersView.cellNextSetTimerDelegate = self
    }
    
    private func setupView() {
        view.backgroundColor = .specialBackground
        
        view.addSubview(mainLabel)
        view.addSubview(closeButton)
        view.addSubview(circularImageView)
        view.addSubview(timerLabel)
        view.addSubview(detailsLabel)
        view.addSubview(timerParametersView)
        view.addSubview(finishButton)
    }
    
    @objc private func closeButtonTapped() {
        dismiss(animated: true)
        timer.invalidate()
    }
    
    @objc private func finishButtonTapped() {
        if numberOfSet == workoutModel.workoutSets {
            dismiss(animated: true)
            RealmManager.shared.updateStatusWorkoutModel(model: workoutModel)
        } else {
            alertOkCancel(title: "Warning", message: "You haven't finish your workout") {
                self.dismiss(animated: true)
            }
        }
        timer.invalidate()
    }
    
    private func addTaps() {
        let firstTapLabel = UITapGestureRecognizer(target: self, action: #selector(startTimer))
        timerLabel.isUserInteractionEnabled = true
        timerLabel.addGestureRecognizer(firstTapLabel)
    }
    
    @objc private func startTimer() {
        timerParametersView.editingButton.isEnabled = false
        timerParametersView.nextSetButton.isEnabled = false
        
        if numberOfSet == workoutModel.workoutSets {
            alertOk(title: "Error", message: "Finish your workout")
        } else {
            basicAnimation()
            timer = Timer.scheduledTimer(timeInterval: 1,
                                         target: self,
                                         selector: #selector(timerAction),
                                         userInfo: nil,
                                         repeats: true)
        }
    }
    
    @objc private func timerAction() {
        durationTimer -= 1
        print(durationTimer)
        
        if durationTimer == 0 {
            timer.invalidate()
            durationTimer = workoutModel.workoutTimer
            numberOfSet += 1
            timerParametersView.numberOfSetLabel.text = "\(numberOfSet)/\(workoutModel.workoutSets)"
            
            timerParametersView.editingButton.isEnabled = true
            timerParametersView.nextSetButton.isEnabled = true
        }
        
        let (min, sec) = durationTimer.convertSec()
        timerLabel.text = "\(min):\(sec.setZeroForSec())"
    }
    
    private func setWorkoutsParameters() {
        timerParametersView.mainLabel.text = workoutModel.workoutName
        timerParametersView.numberOfSetLabel.text = "\(numberOfSet)/\(workoutModel.workoutSets)"
        
        let (min, sec) = workoutModel.workoutTimer.convertSec()
        timerParametersView.numberTimeOfSetLabel.text = "\(min) min \(sec) sec"
        
        timerLabel.text = "\(min):\(sec.setZeroForSec())"
        durationTimer = workoutModel.workoutTimer
    }
}

extension TimerWorkoutViewController {
    
    private func animationCircular() {
        let center = CGPoint(x: circularImageView.frame.width / 2,
                             y: circularImageView.frame.height / 2)
        
        let endAngle = (-CGFloat.pi / 2)
        let startAngle = 2 * CGFloat.pi + endAngle
        
        let circularPath = UIBezierPath(arcCenter: center,
                                        radius: circularImageView.frame.width / 12 + 90,
                                        startAngle: startAngle,
                                        endAngle: endAngle,
                                        clockwise: false)
        shapeLayer.path = circularPath.cgPath
        shapeLayer.lineWidth = 21
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeEnd = 1
        shapeLayer.lineCap = .round
        shapeLayer.strokeColor = UIColor.specialGreen.cgColor
        circularImageView.layer.addSublayer(shapeLayer)
    }
    
    private func basicAnimation() {
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        basicAnimation.toValue = 0
        basicAnimation.duration = CFTimeInterval(durationTimer)
        basicAnimation.fillMode = .forwards
        basicAnimation.isRemovedOnCompletion = true
        shapeLayer.add(basicAnimation, forKey: "basicAnimation")
    }
}

extension TimerWorkoutViewController: NextSetTimerProtocol {
    func nextSetTimerTapped() {
        if numberOfSet < workoutModel.workoutSets {
            numberOfSet += 1
            timerParametersView.numberOfSetLabel.text = "\(numberOfSet)/\(workoutModel.workoutSets)"
        } else {
            alertOk(title: "Error", message: "Finish your workout")
        }
    }
    
    func editingTimerTapped() {
        customAlert.alertCustom(viewController: self,
                                repsOrTimer: "Timer of set", completion: { [self] sets, timerOfSet in
            if sets != "" && timerOfSet != "" {
                guard let numberOfSets = Int(sets) else { return }
                guard let numberOfTimer = Int(timerOfSet) else { return }
                let (min, sec) = numberOfTimer.convertSec()
                timerParametersView.numberOfSetLabel.text = "\(numberOfSet)/\(sets)"
                timerParametersView.numberTimeOfSetLabel.text = "\(min) min \(sec) sec"
                timerLabel.text = "\(min):\(sec.setZeroForSec())"
                durationTimer = numberOfTimer
                
                RealmManager.shared.updateSetsTimerWorkoutModel(model: workoutModel,
                                                                sets: numberOfSets,
                                                                timer: numberOfTimer)
            }
        })
    }
}

extension TimerWorkoutViewController {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            mainLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            mainLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            closeButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            closeButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            
            circularImageView.topAnchor.constraint(equalTo: mainLabel.bottomAnchor, constant: 30),
            circularImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            timerLabel.leadingAnchor.constraint(equalTo: circularImageView.leadingAnchor, constant: 40),
            timerLabel.trailingAnchor.constraint(equalTo: circularImageView.trailingAnchor, constant: -40),
            timerLabel.centerYAnchor.constraint(equalTo: circularImageView.centerYAnchor),
            
            detailsLabel.topAnchor.constraint(equalTo: circularImageView.bottomAnchor, constant: 15),
            detailsLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 25),
            
            timerParametersView.topAnchor.constraint(equalTo: detailsLabel.bottomAnchor, constant: 3),
            timerParametersView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            timerParametersView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            timerParametersView.heightAnchor.constraint(equalToConstant: 270),
            
            finishButton.topAnchor.constraint(equalTo: timerParametersView.bottomAnchor, constant: 15),
            finishButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            finishButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            finishButton.heightAnchor.constraint(equalToConstant: 55)
        ])
    }
}
