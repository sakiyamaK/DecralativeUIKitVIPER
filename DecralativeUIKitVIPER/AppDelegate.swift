//
//  AppDelegate.swift
//  DecralativeUIKitVIPER
//
//  Created by sakiyamaK on 2022/08/01.
//

import IQKeyboardManagerSwift
import UIKit
import RxOptional
import RxViewController

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    private var appRouter: AppRouter?

    func application(_: UIApplication, didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        #if DEBUG
        Bundle(path: "/Applications/InjectionIII.app/Contents/Resources/iOSInjection.bundle")?.load()
        #endif
        IQKeyboardManager.shared.enable = true
        let appRouter = AppRouter.assembleModules()
        self.appRouter = appRouter
        appRouter.runApp()
        return true
    }
}
