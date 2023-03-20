//
//  Notifications.swift
//  Fitness
//
//  Created by KODDER on 20.03.2023.
//

import UIKit
import UserNotifications

class Notifications: NSObject {
    
    let notificationCenter = UNUserNotificationCenter.current()
    
    //Доступ на отправку уведомлений
    func requestAuthorization() {
        notificationCenter.requestAuthorization(options: [.alert, .sound]) { granted, error in
            guard granted else { return }
            self.getNotificationSettings()
        }
    }
    
    func getNotificationSettings() {
        notificationCenter.getNotificationSettings { settings in
//            print(settings)
        }
    }
    
    //Создание ноти
    func scheduleDateNotification(date: Date, id: String) {
        let content = UNMutableNotificationContent()
        content.title = "Workout"
        content.body = "Today you have workout"
        content.sound = .default
        
        //Расписание
        var calendar = Calendar.current
        calendar.timeZone = TimeZone(abbreviation: "UTC")!
        var triggerDate = calendar.dateComponents([.year, .month, .day], from: date)
        triggerDate.hour = 21
        triggerDate.minute = 20
        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: false)
        
        let request = UNNotificationRequest(identifier: id, content: content, trigger: trigger)
        notificationCenter.add(request) { error in
            if error != nil {
                print(error?.localizedDescription ?? "notifi error")
            }
        }
    }
}

extension Notifications: UNUserNotificationCenterDelegate {
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.banner, .sound])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        UIApplication.shared.applicationIconBadgeNumber = 0
        notificationCenter.removeAllDeliveredNotifications()
    }
}
