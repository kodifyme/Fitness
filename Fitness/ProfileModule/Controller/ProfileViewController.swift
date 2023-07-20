//
//  ProfileViewController.swift
//  Fitness
//
//  Created by KODDER on 11.01.2023.
//

import UIKit
import RealmSwift

struct ResultWorkout {
    let name: String
    let result: Int
    let imageData: Data?
}

class ProfileViewController: UIViewController {
    
    //MARK: - TOP
    
    private let nameLabel = UILabel(text: "KODDI", font: .robotoMedium24(), textColor: .white)
    
    private let userImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "UserPhoto")
        imageView.layer.borderWidth = 5
        imageView.clipsToBounds = true
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let topView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.backgroundColor = .specialGreen
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var heightLabel = UILabel(text: "Height: 178", font: .robotoBold16(), textColor: .specialGray)
    private var weightLabel = UILabel(text: "Weight: 77", font: .robotoBold16(), textColor: .specialGray)
    
    private lazy var editingButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "MoreCircle")?.withRenderingMode(.alwaysOriginal), for: .normal)
        button.setTitle("Editing ", for: .normal)
        button.titleLabel?.tintColor = .specialGreen
        button.titleLabel?.font = UIFont.robotoMedium16()
        button.addTarget(self, action: #selector(editingButtonTapped), for: .touchUpInside)
        button.semanticContentAttribute = .forceRightToLeft
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    //MARK: -  Middle
    
    private let workoutCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 3
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(WorkoutCollectionViewCell.self,
                                forCellWithReuseIdentifier: WorkoutCollectionViewCell.identifier)
        collectionView.backgroundColor = .none
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    //MARK: - Button
    
    private let targetLabel = UILabel(text: "TARGET: 20 workouts", font: .robotoBold16(), textColor: .specialGray)
    
    private let localRealm = try! Realm()
    private var workoutArray: Results<WorkoutModel>!
    private var userArray: Results<UserModel>!
    
    private var resultWorkout = [ResultWorkout]()
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        userImageView.layer.cornerRadius = userImageView.frame.width / 2
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        resultWorkout = [ResultWorkout]()
        getWorkoutResults()
        workoutCollectionView.reloadData()
        setupUserParameters()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setConstraints()
        
        userArray = localRealm.objects(UserModel.self)
        
        workoutCollectionView.delegate = self
        workoutCollectionView.dataSource = self
    }
    
    private func setupView() {
        view.backgroundColor = .specialBackground
        
        view.addSubview(topView)
        view.addSubview(nameLabel)
        view.addSubview(userImageView)
        view.addSubview(heightLabel)
        view.addSubview(weightLabel)
        view.addSubview(editingButton)
        view.addSubview(workoutCollectionView)
        view.addSubview(targetLabel)
    }
    
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
    
    private func getWorkoutResults() {
        let nameArray = getWorkoutsName()
        
        for name in nameArray {
            let predicateName = NSPredicate(format: "workoutName = '\(name)'")
            workoutArray = localRealm.objects(WorkoutModel.self).filter(predicateName).sorted(byKeyPath: "workoutName")
            var result = 0
            var image: Data?
            workoutArray.forEach { model in
                result += model.workoutReps
                image = model.workoutImage
            }
            let resultModel = ResultWorkout(name: name, result: result, imageData: image)
            resultWorkout.append(resultModel)
        }
    }
    
    private func setupUserParameters() {
        
        if userArray.count != 0 {
            nameLabel.text = userArray[0].userFirstName + " " + userArray[0].userSecondName
            heightLabel.text = "Height: \(userArray[0].userHeight)"
            weightLabel.text = "Weight: \(userArray[0].userWeight)"
            
            guard let data = userArray[0].userImage else { return }
            guard let image = UIImage(data: data) else { return }
            userImageView.image = image
        }
    }
    
    @objc private func editingButtonTapped() {
        let editingProfileVC = EditingProfileViewController()
        editingProfileVC.modalPresentationStyle = .fullScreen
        present(editingProfileVC, animated: true)
    }
}

//MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension ProfileViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WorkoutCollectionViewCell.identifier, for: indexPath) as? WorkoutCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.backgroundColor = (indexPath.row % 4 == 0 || indexPath.row % 4 == 3 ? .specialGreen : .specialYellow) 
        return cell
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension ProfileViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 170, height: 120)
    }
}

//MARK: - Constraints
extension ProfileViewController {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            
            topView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            topView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            topView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            topView.heightAnchor.constraint(equalToConstant: 115),
            
            nameLabel.bottomAnchor.constraint(equalTo: topView.bottomAnchor, constant: -15),
            nameLabel.centerXAnchor.constraint(equalTo: topView.centerXAnchor),
            
            userImageView.centerXAnchor.constraint(equalTo: topView.centerXAnchor),
            userImageView.centerYAnchor.constraint(equalTo: topView.topAnchor),
            userImageView.heightAnchor.constraint(equalToConstant: 100),
            userImageView.widthAnchor.constraint(equalToConstant: 100),
            
            heightLabel.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: 5),
            heightLabel.leftAnchor.constraint(equalTo: topView.leftAnchor, constant: 20),
            
            weightLabel.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: 5),
            weightLabel.leftAnchor.constraint(equalTo: heightLabel.rightAnchor, constant: 10),
            
            editingButton.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: 5),
            editingButton.rightAnchor.constraint(equalTo: topView.rightAnchor),
            
            workoutCollectionView.topAnchor.constraint(equalTo: heightLabel.bottomAnchor, constant: 20),
            workoutCollectionView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            workoutCollectionView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            workoutCollectionView.heightAnchor.constraint(equalToConstant: 250),
            
            targetLabel.topAnchor.constraint(equalTo: workoutCollectionView.bottomAnchor, constant: 20),
            targetLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20)
        ])
    }
}
