//
//  MachinesViewController.swift
//  ProSpace
//
//  Created by PCCWS - User on 22/9/21.
//

import UIKit

class MachinesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var arrMachines: [Machine] = []
    var arrIDMachine: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "MachinesTableViewCell", bundle: nil), forCellReuseIdentifier: "machine")
        setupData()
    }
    
    func setupData() {
        arrMachines.removeAll()
        fetchMachineData()
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrMachines.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "machine") as! MachinesTableViewCell
        cell.machine = arrMachines[indexPath.row]
        cell.editCompletion = { item in
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "AddMachineViewController") as! AddMachineViewController
            vc.edit = true
            vc.machine = item
            self.navigationController?.pushViewController(vc, animated: true)
        }
        cell.setupView()
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            var indexDelete: Int?
            for item in 0...arrIDMachine.count-1 {
                if arrIDMachine[item] == arrMachines[indexPath.row].id {
                    indexDelete = item
                }
            }
            arrIDMachine.remove(at: indexDelete ?? 0)
            arrMachines.remove(at: indexPath.row)
            UserProfileDataStore.saveLocalArrMachine(machines: arrIDMachine)
            setupData()
        }
    }
    
    func fetchMachineData() {
        arrIDMachine = UserProfileDataStore.getLocallySavedArrMachine() ?? []
        for item in arrIDMachine {
            if let machine = UserProfileDataStore.getLocallySavedMachineByID(id: item) {
                arrMachines.append(machine)
            }
        }
    }
    
    @IBAction func sortByName(_ sender: UIButton) {
        arrMachines = arrMachines.sorted {
            $0.name ?? "" < $1.name ?? ""
        }
        tableView.reloadData()
    }
    
    @IBAction func sortByType(_ sender: UIButton) {
        arrMachines = arrMachines.sorted {
            $0.type ?? "" < $1.type ?? ""
        }
        tableView.reloadData()
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
