//
//  Machine.swift
//  ProSpace
//
//  Created by PCCWS - User on 22/9/21.
//

import UIKit

class Machine: NSObject, NSCoding {
    var id: String?
    var name: String?
    var type: String?
    var qrNumber: String?
    var lastMaintenance: String?
    var images: [String] = []
    
    init(id: String, name: String, type: String, qrNumber: String, lastMaintenance: String, images: [String]) {
        self.id = id
        self.name = name
        self.type = type
        self.qrNumber = qrNumber
        self.lastMaintenance = lastMaintenance
        self.images = images
    }
    
    func saveLocalData() {
        UserProfileDataStore.saveLocalMachine(machine: self)
    }
    
    
    // NSCoding
    func encode(with coder: NSCoder) {
        coder.encode(id, forKey: "id")
        if let stringId = id {
            coder.encode(name, forKey: "\(stringId)name")
            coder.encode(type, forKey: "\(stringId)type")
            coder.encode(qrNumber, forKey: "\(stringId)qrNumber")
            coder.encode(lastMaintenance, forKey: "\(stringId)lastMaintenance")
            coder.encode(images, forKey: "\(stringId)images")
        }
    }
    
    required convenience init?(coder: NSCoder) {
        self.init(id: "", name: "", type: "", qrNumber: "", lastMaintenance: "", images: [])
        id = coder.decodeObject(forKey: "id") as? String
        if let stringId = id {
            name = coder.decodeObject(forKey: "\(stringId)name") as? String
            type = coder.decodeObject(forKey: "\(stringId)type") as? String
            qrNumber = coder.decodeObject(forKey: "\(stringId)qrNumber") as? String
            lastMaintenance = coder.decodeObject(forKey: "\(stringId)lastMaintenance") as? String
            images = coder.decodeObject(forKey: "\(stringId)images") as? [String] ?? []
        }
    }
}
