//
//  UserProfileDataStore.swift
//  ProSpace
//
//  Created by PCCWS - User on 22/9/21.
//

import UIKit

class UserProfileDataStore: NSObject {
    
    static func clearRegisterUser() {
        clearCurrentAccount()
        UserDefaultManager.removeUserDefault(forKey: .userProfile)
    }
    
    // Setting current account
    static func saveLocalMachine(machine: Machine) {
        let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: machine)
        UserDefaultManager.setKeyedObjectID(encodedData: encodedData, forKey: machine.id ?? "")
    }
    
    static func saveLocalArrMachine(machines: [String]) {
        let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: machines)
        UserDefaultManager.setKeyedObject(encodedData: encodedData, forKey: .arrMachine)
    }
    
    static func getLocallySavedArrMachine() -> [String]? {
        if let decoded = UserDefaultManager.getKeyedObject(key: .arrMachine) {
            return NSKeyedUnarchiver.unarchiveObject(with: decoded) as? [String]
        }
        return nil
    }
    
    static func getLocallySavedMachineByID(id: String) -> Machine? {
        if let decoded = UserDefaultManager.getKeyedObjectString(key: id) {
            return NSKeyedUnarchiver.unarchiveObject(with: decoded) as? Machine
        }
        return nil
    }
    
    static func clearCurrentAccount() {
        UserDefaultManager.removeUserDefault(forKey: .currentAccount)
    }
}


