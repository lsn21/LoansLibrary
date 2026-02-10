//
//  LoanRemoteConfig.swift
//  LoansHelpers
//
//  Created by Siarhei Lukyanau on 31.10.25.
//

import Foundation
import FirebaseCore
import FirebaseRemoteConfig

public class LoanRemoteConfig {
    
    private static var remoteConfigLoan: RemoteConfig?
    
    public static var isShowOnboarding = false
    static var isOnboarding: Bool {
        set {
            isShowOnboarding = newValue
            NotificationCenter.default.post(name: Notification.Name("testLaunch"), object: self)
        }
        get {
            self.isShowOnboarding
        }
    }
    public static var showLoaderByTimer = false
    public static var review = false
    public static var showSmsScreen = false
    
    public static var tabBarIndex = 0
    
    public static var urlTerms = ""
    public static var urlPrivacy = ""
    public static var urlAfterDemo = ""
    public static var urlAfterForm = ""
    public static var urlAfterLaunch = ""

    private init() { }
    
    class func getRemoteValues() {
        remoteConfigLoan?.activate()
        
        review = bool(forKey: "review")
        isOnboarding = bool(forKey: "isShowOnboarding")
        showLoaderByTimer = bool(forKey: "app_show_loader_by_timer")
        showSmsScreen = bool(forKey: "app_show_sms_screen")
        
        tabBarIndex = int(forKey: "init_tabBar_loan_screen_index")
        
        urlTerms = string(forKey: "app_terms_of_use_url")
        urlPrivacy = string(forKey: "app_privacy_policy_url")

        urlAfterDemo = string(forKey: "app_keitaro_afterdemo")
        urlAfterForm = string(forKey: "app_keitaro_url_afterform")
        urlAfterLaunch = string(forKey: "app_keitaro_url_afterapplaunch")
    }
    
    public class func fetchCloudValues() {
        remoteConfigLoan = RemoteConfig.remoteConfig()
        let settings = RemoteConfigSettings()
        settings.minimumFetchInterval = 0
        remoteConfigLoan?.configSettings = settings
        
        remoteConfigLoan?.fetch() { (status, error) in
            print(status)
            if let error = error {
                print ("Error fetching remote values \(error)")
                return
            }
            getRemoteValues()
        }
    }
    
    class func bool(forKey key: String) -> Bool {
        let b = remoteConfigLoan?.configValue(forKey: key).boolValue ?? false
        return b
    }
    
    class func string(forKey key: String) -> String {
        let str = remoteConfigLoan?.configValue(forKey: key).stringValue ?? ""
        return str
    }
    
    class func int(forKey key: String) -> Int {
        let i = remoteConfigLoan?.configValue(forKey: key).numberValue.intValue ?? 0
        return i
    }
}
