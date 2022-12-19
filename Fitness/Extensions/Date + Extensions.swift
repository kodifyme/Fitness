//
//  Date + Extensions.swift
//  Fitness
//
//  Created by KODDER on 19.12.2022.
//

import Foundation

extension Date {
    
    func getWeekdayNumber() -> Int {
        let calendar = Calendar.current
        let weekday = calendar.component(.weekday, from: self)
        return weekday
    }
}
