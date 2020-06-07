//
//  AppDelegate.swift
//  HeyLiveCam
//
//  Created by Shree on 19/12/19.
//  Copyright © 2019 Shree. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        //Set Default Settings
        if(UserDefaults.standard.isFirstTimeLoadApp() == false) {
            
            //Set Current Device Language
            if let currentDeviceLanguage = Locale.current.languageCode {
                let strLanguage = currentDeviceLanguage.lowercased()
                if strLanguage == "en" {
                    UserDefaults.standard.setSettingLanguageStatus(value: 1)
                } else {
                    UserDefaults.standard.setSettingLanguageStatus(value: 2)
                }
                Bundle.setLanguage(lang: currentDeviceLanguage)
                
            } else {
                Bundle.setLanguage(lang: "en")
                UserDefaults.standard.setSettingLanguageStatus(value: 1)
            }
            
            UserDefaults.standard.setFirstTimeLoadApp(value: true)
            UserDefaults.standard.setSettingCaptureAudioWithVideo(value: true)
            UserDefaults.standard.setSettingKeepScreenAwake(value: true)
            UserDefaults.standard.setSettingStoreGeolocationOnMedia(value: true)
            UserDefaults.standard.setSettingVideoResolution(value: true)
            
            UserDefaults.standard.setSettingStartRecordingVideo(value: "START".getLocalized())
            UserDefaults.standard.setSettingStopRecordingVideo(value: "STOP".getLocalized())
            UserDefaults.standard.setSettingTakePhoto(value: "IMAGE".getLocalized())
            UserDefaults.standard.setSettingTakeLivePhoto(value: "LIVE PHOTO".getLocalized())
            UserDefaults.standard.setSettingReverseCamera(value: "REVERSE".getLocalized())
            UserDefaults.standard.setSettingCloseHeyCamera(value: "CLOSE APP".getLocalized())
            
            UserDefaults.standard.setSettingCameraSoundEffect(value: true)
            UserDefaults.standard.setSettingTrimTheEndOfVideos(value: 0)
        }
        
        let strLastDate = UserDefaults.Main.string(forKey: .last_date)
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        let str_current_date = formatter.string(from: date)
        if strLastDate.count == 0 {
            
            UserDefaults.Main.set(str_current_date, forKey: .last_date)
            UserDefaults.Main.set(0, forKey: .int_photo_shoot_by_voice_counter)
            
        } else if strLastDate != str_current_date {
            
            UserDefaults.Main.set(str_current_date, forKey: .last_date)
            UserDefaults.Main.set(0, forKey: .int_photo_shoot_by_voice_counter)
        }
        
        //Get In App Purchase Price
        self.getInAppPurchasePrice()
        
        return true
    }
    func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
        
        print("Restoration Handler")
        
      return true
    }
    func resetApp() {
       UIApplication.shared.windows[0].rootViewController = UIStoryboard(
           name: "Main",
           bundle: nil
           ).instantiateInitialViewController()
    }
    // MARK: UISceneSession Lifecycle
    @available(iOS 13.0, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "HeyLiveCam")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    func getInAppPurchasePrice() {
        
        IAPManager.shared.loadProducts(productIds: [strInAppPurchase]) { (products, error) -> Void in
            if error != nil {
                
            } else {
                if let product = products?.first {
                    // Get its price from iTunes Connect
                    let numberFormatter = NumberFormatter()
                    numberFormatter.formatterBehavior = .behavior10_4
                    numberFormatter.numberStyle = .currency
                    numberFormatter.locale = product.priceLocale
                    if let price = numberFormatter.string(from: product.price) {
                        let in_app_purchase_price = String(describing: price)
                        UserDefaults.Main.set(in_app_purchase_price, forKey: .in_app_purchase_price)
                    }
                }
            }
        }
    }
}

