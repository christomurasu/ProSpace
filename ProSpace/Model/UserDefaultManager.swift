//
//  UserDefaultManager.swift
//  ProSpace
//
//  Created by PCCWS - User on 22/9/21.
//

import Foundation

enum UserDefaultItem: String {
    
    case arrMachine
    // Register User Data
    case registerToken
    case registerMobile
    case registerUserName
    case registerEmail
    case registerPassword
    case referalCode
    case isSuccessfullyLoggedIn
    // For biometric & Login users
    case biometric
    case biometricInfo
    case userType
    case token
    case userToken
    case tokenExpiredDate
    case tokenValid
    case fcmToken
    case deviceId
    // Server updated deviceID and FCM token
    case savedFcmToken
    // User Profile
    case userProfile
    case currentAccount
    // KYC
    case packageId
    case transactionId
    case indihomeNum
    // T-Money
    case tmoneyInfo
    // isLanguageSet
    case isLanguageSet
    // For migration check - v1.1.10
    case needMigrationUpdate
}

class UserDefaultManager {
    
    class func setUserDefault(value: String, forKey key: UserDefaultItem) {
        UserDefaults.standard.setValue(value, forKey: key.rawValue)
        UserDefaults.standard.synchronize()
    }
    
    class func setUserDefault(value: Bool, forKey key: UserDefaultItem) {
        UserDefaults.standard.setValue(value, forKey: key.rawValue)
        UserDefaults.standard.synchronize()
    }
    
    class func removeUserDefault(forKey key: UserDefaultItem) {
        UserDefaults.standard.removeObject(forKey: key.rawValue)
        UserDefaults.standard.synchronize()
    }
    
    class func removeUserDefaultID(forKey key: String) {
        UserDefaults.standard.removeObject(forKey: key)
        UserDefaults.standard.synchronize()
    }
    
    class func setKeyedObject(encodedData: Data, forKey key: UserDefaultItem) {
        UserDefaults.standard.set(encodedData, forKey: key.rawValue)
        UserDefaults.standard.synchronize()
    }
    
    class func setKeyedObjectID(encodedData: Data, forKey key: String) {
        UserDefaults.standard.set(encodedData, forKey: key)
        UserDefaults.standard.synchronize()
    }
    
    class func getUserDefault(key: UserDefaultItem) -> String? {
        return UserDefaults.standard.string(forKey: key.rawValue)
    }
    
    
    class func getUserDefaultBoolValue(key: UserDefaultItem) -> Bool? {
        return UserDefaults.standard.bool(forKey: key.rawValue)
    }
    
    class func getKeyedObject(key: UserDefaultItem) -> Data? {
        return UserDefaults.standard.data(forKey: key.rawValue)
    }
    
    class func getKeyedObjectString(key: String) -> Data? {
        return UserDefaults.standard.data(forKey: key)
    }
}


