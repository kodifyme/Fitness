//
//  Int + Extensions.swift
//  Fitness
//
//  Created by KODDER on 10.01.2023.
//

import Foundation

extension Int {
    
    func convertSec() -> (Int, Int) {
        let min = self / 60
        let sec = self % 60
        return (min, sec)
    }
    
    func setZeroForSec() -> String {
        return (Double(self) / 10.0 < 1 ? "0\(self)" : "\(self)")
    }
}
