//
//  AddMachineViewController.swift
//  ProSpace
//
//  Created by PCCWS - User on 22/9/21.
//

import UIKit
import PhotosUI

class AddMachineViewController: UIViewController {
    
    @IBOutlet weak var addPhotos: UIBarButtonItem!
    var configuration = PHPickerConfiguration()
    var arrImages: [UIImage] = []
    
    @IBOutlet weak var machineIdTextField: UITextField!
    @IBOutlet weak var machineNameTextField: UITextField!
    @IBOutlet weak var machineTypeTextField: UITextField!
    @IBOutlet weak var machineQRTextField: UITextField!
    @IBOutlet weak var machineMaintenanceDateTextField: UITextField!
    @IBOutlet weak var image1: UIButton!
    @IBOutlet weak var image2: UIButton!
    @IBOutlet weak var image3: UIButton!
    @IBOutlet weak var image4: UIButton!
    @IBOutlet weak var image5: UIButton!
    @IBOutlet weak var image6: UIButton!
    @IBOutlet weak var image7: UIButton!
    @IBOutlet weak var image8: UIButton!
    @IBOutlet weak var image9: UIButton!
    @IBOutlet weak var image10: UIButton!
    let datePicker = UIDatePicker()
    var edit: Bool = false
    var machine: Machine?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupData()
        // Do any additional setup after loading the view.
    }
    
    func setupData() {
        configuration.selectionLimit = 10
        configuration.filter = .images
        configuration.filter = .any(of: [.livePhotos, .images])
        machineQRTextField.keyboardType = .numberPad
        machineIdTextField.text = randomAlphaNumericString(length: 10)
        showDatePicker()
        
        if edit == true, let item = machine {
            machineIdTextField.text = item.id
            machineNameTextField.text = item.name
            machineTypeTextField.text = item.type
            machineQRTextField.text = item.qrNumber
            machineMaintenanceDateTextField.text = item.lastMaintenance
            for index in 0...item.images.count-1 {
                let image = convertBase64StringToImage(imageBase64String: item.images[index])
                switch index {
                case 0:
                    self.image1.setBackgroundImage(image, for: .normal)
                case 1:
                    self.image2.setBackgroundImage(image, for: .normal)
                case 2:
                    self.image3.setBackgroundImage(image, for: .normal)
                case 3:
                    self.image4.setBackgroundImage(image, for: .normal)
                case 4:
                    self.image5.setBackgroundImage(image, for: .normal)
                case 5:
                    self.image6.setBackgroundImage(image, for: .normal)
                case 6:
                    self.image7.setBackgroundImage(image, for: .normal)
                case 7:
                    self.image8.setBackgroundImage(image, for: .normal)
                case 8:
                    self.image9.setBackgroundImage(image, for: .normal)
                case 9:
                    self.image10.setBackgroundImage(image, for: .normal)
                default:
                    break
                }
            }
        }
    }
    

    @IBAction func addPhotos(_ sender: Any) {
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self
        present(picker, animated: true, completion: nil)
    }
    
    func showDatePicker(){
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donedatePicker));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker));

        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)

        machineMaintenanceDateTextField.inputAccessoryView = toolbar
        machineMaintenanceDateTextField.inputView = datePicker

     }
    
    @objc func donedatePicker(){
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        machineMaintenanceDateTextField.text = formatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }

    @objc func cancelDatePicker(){
        self.view.endEditing(true)
    }
    
    func setupDataImage(results: [PHPickerResult]) {
        arrImages.removeAll()
        for index in 0...results.count-1 {
            let prov = results[index].itemProvider
            prov.loadObject(ofClass: UIImage.self) { imageMaybe, errorMaybe in
                if let image = imageMaybe as? UIImage {
                    self.arrImages.append(image)
                    DispatchQueue.main.async {
                        switch index {
                        case 0:
                            self.image1.setBackgroundImage(image, for: .normal)
                        case 1:
                            self.image2.setBackgroundImage(image, for: .normal)
                        case 2:
                            self.image3.setBackgroundImage(image, for: .normal)
                        case 3:
                            self.image4.setBackgroundImage(image, for: .normal)
                        case 4:
                            self.image5.setBackgroundImage(image, for: .normal)
                        case 5:
                            self.image6.setBackgroundImage(image, for: .normal)
                        case 6:
                            self.image7.setBackgroundImage(image, for: .normal)
                        case 7:
                            self.image8.setBackgroundImage(image, for: .normal)
                        case 8:
                            self.image9.setBackgroundImage(image, for: .normal)
                        case 9:
                            self.image10.setBackgroundImage(image, for: .normal)
                        default:
                            break
                        }
                    }
                }
            }
        }
    }

    @IBAction func saveButton(_ sender: UIButton) {
        let id = machineIdTextField.text
        let name = machineNameTextField.text
        let type = machineTypeTextField.text
        let qr = machineQRTextField.text
        let date = machineMaintenanceDateTextField.text
        
        if name?.isEmpty == false, type?.isEmpty == false, qr?.isEmpty == false, date?.isEmpty == false {
            
            if edit == true {
                var arrStringImages: [String] = []
                for item in arrImages {
                    arrStringImages.append(convertImageToBase64String(img: item))
                }
                let machine = Machine.init(id: id!, name: name!, type: type!, qrNumber: qr!, lastMaintenance: date!, images: arrStringImages)
                UserProfileDataStore.saveLocalMachine(machine: machine)
                self.navigationController?.popViewController(animated: true)
            } else if edit == false {
                var arrStringImages: [String] = []
                arrStringImages.removeAll()
                for item in arrImages {
                    arrStringImages.append(convertImageToBase64String(img: item))
                }
                let machine = Machine.init(id: id!, name: name!, type: type!, qrNumber: qr!, lastMaintenance: date!, images: arrStringImages)
                var arrMachineID: [String] = UserProfileDataStore.getLocallySavedArrMachine() ?? []
                arrMachineID.append(machine.id ?? "")
                UserProfileDataStore.saveLocalArrMachine(machines: arrMachineID)
                UserProfileDataStore.saveLocalMachine(machine: machine)
                self.navigationController?.popViewController(animated: true)
            }
        }
        
        
    }
    
    func randomAlphaNumericString(length: Int) -> String {
        let allowedChars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let allowedCharsCount = UInt32(allowedChars.count)
        var randomString = ""

        for _ in 0 ..< length {
            let randomNum = Int(arc4random_uniform(allowedCharsCount))
            let randomIndex = allowedChars.index(allowedChars.startIndex, offsetBy: randomNum)
            let newCharacter = allowedChars[randomIndex]
            randomString += String(newCharacter)
        }

        return randomString
    }
    
    func convertImageToBase64String (img: UIImage) -> String {
        return img.jpegData(compressionQuality: 1)?.base64EncodedString() ?? ""
    }
    
    func convertBase64StringToImage (imageBase64String: String) -> UIImage {
        let imageData = Data.init(base64Encoded: imageBase64String, options: .init(rawValue: 0))
        let image = UIImage(data: imageData!)
        return image!
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension AddMachineViewController: PHPickerViewControllerDelegate {
func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        dismiss(animated: true, completion: nil)
        guard !results.isEmpty else { return }
        setupDataImage(results: results)
     }
}
