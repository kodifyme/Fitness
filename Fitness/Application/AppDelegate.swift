//
//  AppDelegate.swift
//  Fitness
//
//  Created by KODDER on 29.11.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    let notification = Notifications()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        notification.requestAuthorization()
        notification.notificationCenter.delegate = notification
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
}

//TODO:
/*
 - https://github.com/Loriens/News
 - Добавить в проект SwiftLint. Набор правил можно взять https://github.com/kodecocodes/swift-style-guide/blob/main/com.raywenderlich.swiftlint.yml
 - Подумать над архитектурой слоев в приложении (раскидать красиво по папкам)
 - Исправить косяк с Massive View Controller - всё происходит внутри контроллера, нет разбиения по слоям ответственности
 - Добавить работу с сетью
 - Бонус: Подумать над DI - как работать правильно с сервисами (RealmManager, NetworkService), необходимо их закрывать протоколом и прокидывать в контроллеры как внешнюю зависимость
 */
