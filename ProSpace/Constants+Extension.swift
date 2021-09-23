//
//  Constants.swift
//  ProSpace
//
//  Created by PCCWS - User on 22/9/21.
//

import Foundation
import UIKit

typealias MachineCompletion = (Machine) -> Void

extension ViewController {
    func convertImageToBase64String (img: UIImage) -> String {
        return img.jpegData(compressionQuality: 1)?.base64EncodedString() ?? ""
    }
    
    func convertBase64StringToImage (imageBase64String:String) -> UIImage {
        let imageData = Data.init(base64Encoded: imageBase64String, options: .init(rawValue: 0))
        let image = UIImage(data: imageData!)
        return image!
    }
}
