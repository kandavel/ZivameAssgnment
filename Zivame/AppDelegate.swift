//
//  AppDelegate.swift
//  Zivame
//
//  Created by Kandavel Umapathy on 13/08/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

   //MARK:Globalvariable
    static let callOnce: Void = {
        //PresentViewcontroller Normal Way
        UIViewController.swizzlePresentationStyle()
    }()
    var reachability : Reachability? = nil
    var isInternetConnected:Bool? = nil
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        _ = AppDelegate.callOnce
        setAppCustomAppearance()
        listenToInternetChanges()
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
    
    func setAppCustomAppearance() {
        UINavigationBar.appearance().tintColor = UIColor.Theme.top_nav_back
        UINavigationBar.appearance().backgroundColor = UIColor.Theme.top_nav_backgroud
        UINavigationBar.appearance().barTintColor = UIColor.Theme.top_nav_backgroud
        UINavigationBar.appearance().barStyle = UIBarStyle.default
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.black,NSAttributedString.Key.font: UIFont.Avenir.Black.A2 ]
        UINavigationBar.appearance().isTranslucent = false
    }
    
    func refreshInternetReachability(){
        // After 5 seconds, stop and re-start reachability, this time using a hostname
        self.reachability?.stopNotifier()
        self.reachability = nil
        objc_sync_enter(self)
        self.isInternetConnected = true
        objc_sync_exit(self)
        
        let dispatchTime = DispatchTime.now() + Double(Int64(UInt64(2) * NSEC_PER_SEC)) / Double(NSEC_PER_SEC)
        DispatchQueue.main.asyncAfter(deadline: dispatchTime) {
            self.listenToInternetChanges()
        }
    }
    func listenToInternetChanges(){
        do{
            reachability = Reachability(hostname: "www.google.com")
            reachability?.whenReachable = { reachability in
                // this is called on a background thread, but UI updates must
                // be on the main thread, like this:
                if self.isInternetConnected == nil{
                    objc_sync_enter(self)
                    self.isInternetConnected = true
                    objc_sync_exit(self)
                }else if self.isInternetConnected == false{
                    objc_sync_enter(self)
                    self.isInternetConnected = true
                    objc_sync_exit(self)
                    DispatchQueue.main.async {
                        let nc = NotificationCenter.default
                        nc.post(name: Notification.Name(rawValue:Notifications.ReachabilityChanged), object: nil, userInfo: ["IsInternet" : true])
                        if reachability.isReachableViaWiFi {
                            print("Reachable via WiFi")
                        } else {
                            print("Reachable via Cellular")
                        }
                    }
                }
            }
            reachability?.whenUnreachable = { reachability in
                // this is called on a background thread, but UI updates must
                // be on the main thread, like this:
                if self.isInternetConnected == nil{
                    objc_sync_enter(self)
                    self.isInternetConnected = false
                    objc_sync_exit(self)
                }else if self.isInternetConnected == true{
                    objc_sync_enter(self)
                    self.isInternetConnected = false
                    objc_sync_exit(self)
                    
                    let nc = NotificationCenter.default
                    nc.post(name: Notification.Name(rawValue: Notifications.ReachabilityChanged), object: nil, userInfo: ["IsInternet" : false])
                    DispatchQueue.main.async {
                        if let rootViewController = UIViewController.getTopViewController(){
                            if let noInternetVc = NoInternetViewController.getNoInternetController(){
                                noInternetVc.modalPresentationStyle = .overCurrentContext
                                noInternetVc.providesPresentationContextTransitionStyle = true;
                                noInternetVc.definesPresentationContext = true;
                                rootViewController.present(noInternetVc, animated: false, completion: nil)
                                print("Not reachable")
                            }
                        }
                    }
                }
            }
            try reachability?.startNotifier()
        }catch{
            print("Unable to start notifier")
        }
    }

}

