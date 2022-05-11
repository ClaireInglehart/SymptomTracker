//
//  AppSettings.swift
//  SymptomTracker
//
//  Created by Mike on 2/22/22.
//

import Foundation

public final class AppSettings: NSObject {

    public static var notification1Enabled: Bool {
        get {
            return getBoolValue(forKeyName: "notification1.enabled.setting") ?? false
        }
        set {
            setBoolValue(forKeyName: "notification1.enabled.setting", value: newValue)
        }
    }

    public static var notification2Enabled: Bool {
        get {
            return getBoolValue(forKeyName: "notification2.enabled.setting") ?? false
        }
        set {
            setBoolValue(forKeyName: "notification2.enabled.setting", value: newValue)
        }
    }

    public static var notification1Time: String? {
        get {
            return getStringValue(forKeyName: "notification1.time.setting")
        }
        set {
            setStringValue(forKeyName: "notification1.time.setting", value: newValue)
        }
    }

    public static var notification2Time: String? {
        get {
            return getStringValue(forKeyName: "notification2.time.setting")
        }
        set {
            setStringValue(forKeyName: "notification2.time.setting", value: newValue)
        }
    }

    

    
    //////////////////////////////////////////////////////////////////////////
    class func getBoolValue(forKeyName keyName: String) -> Bool? {
        return UserDefaults.standard.value(forKey: keyName) as? Bool
    }
    
    class func setBoolValue(forKeyName keyName: String, value: Bool?) {
        UserDefaults.standard.set(value, forKey: keyName)
    }

    class func getStringValue(forKeyName keyName: String) -> String? {
        return UserDefaults.standard.value(forKey: keyName) as? String
    }
    
    class func setStringValue(forKeyName keyName: String, value: String?) {
        UserDefaults.standard.set(value, forKey: keyName)
    }

    class func getIntValue(forKeyName keyName: String) -> Int? {
        return UserDefaults.standard.value(forKey: keyName) as? Int
    }
    
    class func setIntValue(forKeyName keyName: String, value: Int?) {
        UserDefaults.standard.set(value, forKey: keyName)
    }

    @objc public class func getDateValue(forKeyName keyName: String) -> NSDate? {
        return UserDefaults.standard.value(forKey: keyName) as? NSDate
    }
    
    @objc public class func setDateValue(forKeyName keyName: String, value: NSDate?) {
        UserDefaults.standard.set(value, forKey: keyName)
    }

}

