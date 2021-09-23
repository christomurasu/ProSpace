//
//  MachinesTableViewCell.swift
//  ProSpace
//
//  Created by PCCWS - User on 22/9/21.
//

import UIKit

class MachinesTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBOutlet weak var machineName: UILabel!
    @IBOutlet weak var machineType: UILabel!
    var editCompletion: MachineCompletion?
    var machine: Machine?
    
    func setupView() {
        machineName.text = machine?.name
        machineType.text = machine?.type
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func editClicked(_ sender: UIButton) {
        if let machines = self.machine {
            editCompletion?(machines)
        }
    }
}
