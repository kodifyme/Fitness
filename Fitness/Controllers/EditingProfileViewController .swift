//
//  EditingProfileViewController .swift
//  Fitness
//
//  Created by KODDER on 12.01.2023.
//

import UIKit

class EditingProfileViewController: UIViewController {
 
    //MARK: - TOP
    private let mainLabel = UILabel(text: "EDITING PROFILE", font: .robotoMedium24(), textColor: .specialGray)
    
    private let userImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "UserPhoto")
        imageView.layer.borderWidth = 5
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
    
    //MARK: -  Middle
    
    private let firstNameLabel = UILabel(text: "First name")
    
    private let firstNameTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .specialBrown
        textField.layer.cornerRadius = 10
        textField.textColor = .specialGray
        textField.font = .robotoBold20()
        textField.leftView = UIView(frame: CGRect(x: 0,
                                                  y: 0,
                                                  width: 10,
                                                  height: textField.frame.height))
        textField.leftViewMode = .always
        textField.clearButtonMode = .always
        textField.returnKeyType = .done
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let secondNameLabel = UILabel(text: "Second name")
    
    private let secondNameTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .specialBrown
        textField.layer.cornerRadius = 10
        textField.textColor = .specialGray
        textField.font = .robotoBold20()
        textField.leftView = UIView(frame: CGRect(x: 0,
                                                  y: 0,
                                                  width: 10,
                                                  height: textField.frame.height))
        textField.leftViewMode = .always
        textField.clearButtonMode = .always
        textField.returnKeyType = .done
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let heightLabel = UILabel(text: "Height")
    
    private let heightTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .specialBrown
        textField.layer.cornerRadius = 10
        textField.textColor = .specialGray
        textField.font = .robotoBold20()
        textField.leftView = UIView(frame: CGRect(x: 0,
                                                  y: 0,
                                                  width: 10,
                                                  height: textField.frame.height))
        textField.leftViewMode = .always
        textField.clearButtonMode = .always
        textField.returnKeyType = .done
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let weightLabel = UILabel(text: "Weight")
    
    private let weightTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .specialBrown
        textField.layer.cornerRadius = 10
        textField.textColor = .specialGray
        textField.font = .robotoBold20()
        textField.leftView = UIView(frame: CGRect(x: 0,
                                                  y: 0,
                                                  width: 10,
                                                  height: textField.frame.height))
        textField.leftViewMode = .always
        textField.clearButtonMode = .always
        textField.returnKeyType = .done
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var  saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .specialGreen
        button.setTitle("SAVE", for: .normal)
        button.titleLabel?.font = .robotoBold16()
        button.tintColor = .white
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        userImageView.layer.cornerRadius = userImageView.frame.width / 2
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setConstraints()
        
//        setDelegates()
        addTaps()
    }
    
    private func setupView() {
        view.backgroundColor = .specialBackground
        
        view.addSubview(mainLabel)
        view.addSubview(topView)
        view.addSubview(userImageView)
        view.addSubview(firstNameLabel)
        view.addSubview(firstNameTextField)
        view.addSubview(secondNameLabel)
        view.addSubview(secondNameTextField)
        view.addSubview(heightLabel)
        view.addSubview(heightTextField)
        view.addSubview(weightLabel)
        view.addSubview(weightTextField)
        view.addSubview(saveButton)
    }
    
//    private func setDelegates() {
//        firstNameTextField.delegate = self
//        secondNameTextField.delegate = self
//        heightTextField.delegate = self
//        weightTextField.delegate = self
//    }
    
    private func addTaps() {
        let tapScreen = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapScreen)
    }
    
    @objc private func hideKeyboard() {
        view.endEditing(true)
    }
    
    
    @objc private func saveButtonTapped() {
        dismiss(animated: true)
    }
}

//extension EditingProfileViewController: UITextFieldDelegate {
//    private func textFieldShouldReturn(_ textField: UITextField) -> (Bool, Bool, Bool, Bool) {
//        return (firstNameTextField.resignFirstResponder(),
//        secondNameTextField.resignFirstResponder(),
//        heightTextField.resignFirstResponder(),
//        weightTextField.resignFirstResponder())
//    }
//}

extension EditingProfileViewController {
    
    private func setConstraints() {
        
        NSLayoutConstraint.activate([
            mainLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            mainLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            topView.topAnchor.constraint(equalTo: mainLabel.bottomAnchor, constant: 60),
            topView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            topView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            topView.heightAnchor.constraint(equalToConstant: 70),
            
            userImageView.centerXAnchor.constraint(equalTo: topView.centerXAnchor),
            userImageView.centerYAnchor.constraint(equalTo: topView.topAnchor),
            
            firstNameLabel.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: 30),
            firstNameLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30),
            
            firstNameTextField.topAnchor.constraint(equalTo: firstNameLabel.bottomAnchor, constant: 0),
            firstNameTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            firstNameTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            firstNameTextField.heightAnchor.constraint(equalToConstant: 40),
            
            secondNameLabel.topAnchor.constraint(equalTo: firstNameTextField.bottomAnchor, constant: 20),
            secondNameLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30),
            
            secondNameTextField.topAnchor.constraint(equalTo: secondNameLabel.bottomAnchor, constant: 0),
            secondNameTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            secondNameTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            secondNameTextField.heightAnchor.constraint(equalToConstant: 40),
            
            heightLabel.topAnchor.constraint(equalTo: secondNameTextField.bottomAnchor, constant: 20),
            heightLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30),
            
            heightTextField.topAnchor.constraint(equalTo: heightLabel.bottomAnchor, constant: 0),
            heightTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            heightTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            heightTextField.heightAnchor.constraint(equalToConstant: 40),
            
            weightLabel.topAnchor.constraint(equalTo: heightTextField.bottomAnchor, constant: 20),
            weightLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30),
            
            weightTextField.topAnchor.constraint(equalTo: weightLabel.bottomAnchor, constant: 0),
            weightTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            weightTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            weightTextField.heightAnchor.constraint(equalToConstant: 40),
            
            saveButton.topAnchor.constraint(equalTo: weightTextField.bottomAnchor, constant: 40),
            saveButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            saveButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            saveButton.heightAnchor.constraint(equalToConstant: 55)
        ])
    }
}
