//
//  CustomAlert.swift
//  Fitness
//
//  Created by KODDER on 28.12.2022.
//

import UIKit

class CustomAlert {
    
    private let backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.alpha = 0
        return view
    }()
    
    private let alertView: UIView = {
        let view = UIView()
        view.backgroundColor = .specialBackground
        view.layer.cornerRadius = 20
        return view
    }()
    
    private let scrollView = UIScrollView()
    
    private var mainView: UIView?
    
    private var buttonAction: ((String, String) -> Void)?
    
    private let animation = Animation()
    
    private let setTextField = UITextField()
    private let repsTextField = UITextField()
    
    func alertCustom(viewController: UIViewController, repsOrTimer: String,
                     completion: @escaping (String, String) -> Void) {
        
        // Observer
        registerForKeyboardNotification()
        
        guard let parentView = viewController.view else { return }
        mainView = parentView
        
        scrollView.frame = parentView.frame
        parentView.addSubview(scrollView)
        
        backgroundView.frame = parentView.frame
        scrollView.addSubview(backgroundView)
        
        alertView.frame = CGRect(x: 40,
                                 y: -420,
                                 width: parentView.frame.width - 80,
                                 height: 420)
        scrollView.addSubview(alertView)
        
        // Sportsman ImageView
        let sportsmanImageView = UIImageView(frame: CGRect(
            x: (alertView.frame.width - alertView.frame.height * 0.4) / 2,
            y: 30,
            width: alertView.frame.height * 0.4,
            height: alertView.frame.height * 0.4))
        
        sportsmanImageView.image = UIImage(named: "sportsmanAlert")
        sportsmanImageView.contentMode = .scaleAspectFit
        alertView.addSubview(sportsmanImageView)
        
        // Editing Label
        let editingLabel = UILabel(frame: CGRect(x: 10,
                                                 y: alertView.frame.height * 0.4 + 50,
                                                 width: alertView.frame.width - 20,
                                                 height: 25))
        editingLabel.text = "Editing"
        editingLabel.textColor = .specialGray
        editingLabel.textAlignment = .center
        editingLabel.font = .robotoMedium22()
        alertView.addSubview(editingLabel)
        
        // Sets Label
        let setsLabel = UILabel(text: "Sets")
        setsLabel.translatesAutoresizingMaskIntoConstraints = true
        setsLabel.frame = CGRect(x: 30,
                                 y: editingLabel.frame.maxY + 10,
                                 width: alertView.frame.width - 60,
                                 height: 20)
        alertView.addSubview(setsLabel)
        
        // Set TextField
        setTextField.frame = CGRect(x: 20,
                                    y: setsLabel.frame.maxY,
                                    width: alertView.frame.width - 40,
                                    height: 30)
        setTextField.backgroundColor = .specialBrown
        setTextField.borderStyle = .none
        setTextField.layer.cornerRadius = 10
        setTextField.textColor = .specialGray
        setTextField.font = .robotoBold20()
        setTextField.leftView = UIView(frame: CGRect(x: 0,
                                                   y: 0,
                                                   width: 15,
                                                   height: setTextField.frame.height))
        setTextField.leftViewMode = .always
        setTextField.clearButtonMode = .always
        setTextField.returnKeyType = .done
        setTextField.keyboardType = .numberPad
        alertView.addSubview(setTextField)
        
        // Reps Or Timer Label
        let repsOrTimerLabel = UILabel(text: repsOrTimer)
        repsOrTimerLabel.translatesAutoresizingMaskIntoConstraints = true
        repsOrTimerLabel.frame = CGRect(x: 30,
                                 y: setTextField.frame.maxY + 3,
                                 width: alertView.frame.width - 60,
                                 height: 20)
        alertView.addSubview(repsOrTimerLabel)
        
        // Reps TextField
        repsTextField.frame = CGRect(x: 20,
                                    y: repsOrTimerLabel.frame.maxY,
                                    width: alertView.frame.width - 40,
                                    height: 30)
        repsTextField.backgroundColor = .specialBrown
        repsTextField.borderStyle = .none
        repsTextField.layer.cornerRadius = 10
        repsTextField.textColor = .specialGray
        repsTextField.font = .robotoBold20()
        repsTextField.leftView = UIView(frame: CGRect(x: 0,
                                                   y: 0,
                                                   width: 15,
                                                   height: setTextField.frame.height))
        repsTextField.leftViewMode = .always
        repsTextField.clearButtonMode = .always
        repsTextField.returnKeyType = .done
        repsTextField.keyboardType = .numberPad
        alertView.addSubview(repsTextField)
        
        // OK Button
        let okButton = UIButton(frame: CGRect(x: 50,
                                              y: repsTextField.frame.maxY + 15,
                                              width: alertView.frame.width - 100,
                                              height: 35))
        okButton.backgroundColor = .specialGreen
        okButton.setTitle("OK", for: .normal)
        okButton.titleLabel?.textColor = .white
        okButton.titleLabel?.font = .robotoMedium18()
        okButton.layer.cornerRadius = 10
        okButton.addTarget(self, action: #selector(okButtonTapped), for: .touchUpInside)
        alertView.addSubview(okButton)
        
        buttonAction = completion
        
        // Animation
        animation.startAnimation(backgroundView: backgroundView,
                                 alertView: alertView,
                                 parentView: parentView)
    }
    
    private func registerForKeyboardNotification() {
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(kbWillShow),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(kbWillHide),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    private func removeForKeyboardNotification() {
        
        NotificationCenter.default.removeObserver(self,
                                                  name: UIResponder.keyboardWillShowNotification,
                                                  object: nil)
        
        NotificationCenter.default.removeObserver(self,
                                                  name: UIResponder.keyboardWillHideNotification,
                                                  object: nil)
    }
    
    @objc private func okButtonTapped() {
        guard let setsNumber = setTextField.text else { return }
        guard let repsNumber = repsTextField.text else { return }
        buttonAction?(setsNumber, repsNumber)
        
        guard let targetView = mainView else { return }
        
        // End Animation
        animation.endAnimation(targetView: targetView,
                               alertView: alertView,
                               backgroundView: backgroundView,
                               scrollView: scrollView)
        self.setTextField.text = ""
        self.repsTextField.text = ""
        
        // Observer
        removeForKeyboardNotification()
    }
    
    @objc func kbWillShow() {
        scrollView.contentOffset = CGPoint(x: 0, y: 100)
    }
    
    @objc func kbWillHide() {
        scrollView.contentOffset = CGPoint.zero
    }
}
