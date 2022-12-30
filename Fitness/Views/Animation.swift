//
//  Animation.swift
//  Fitness
//
//  Created by KODDER on 30.12.2022.
//

import UIKit

class Animation {
    
    func startAnimation(backgroundView: UIView, alertView: UIView, parentView: UIView) {
        UIView.animate(withDuration: 0.3) {
            backgroundView.alpha = 0.8
        } completion: { done in
            if done {
                UIView.animate(withDuration: 0.3) {
                    alertView.center = parentView.center
                }
            }
        }
    }
    
    func endAnimation(targetView: UIView, alertView: UIView, backgroundView: UIView, scrollView: UIView) {
        UIView.animate(withDuration: 0.3) {
            alertView.frame = CGRect(x: 40,
                                          y: targetView.frame.height,
                                          width: targetView.frame.width - 80,
                                          height: 420)
        } completion: { done in
            UIView.animate(withDuration: 0.3) {
                backgroundView.alpha = 0
            } completion: { done in
                if done {
                    alertView.removeFromSuperview()
                    backgroundView.removeFromSuperview()
                    scrollView.removeFromSuperview()
                }
            }
        }
    }
}
