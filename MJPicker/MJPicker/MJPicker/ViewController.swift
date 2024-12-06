//
//  ViewController.swift
//  MJPicker
//
//  Created by maroleanj on 06/12/24.
//

import UIKit

class ViewController: UIViewController {

    
    var isOn: Bool = false
    
    @IBOutlet weak var contentLbl: UILabel!{
        didSet {
            contentLbl.text = "Single Component Picker"
        }
    }
    @IBOutlet weak var toggleSwitch: UISwitch!
    
    
    @IBAction func butttonAction(_ sender: UIButton) {
        if isOn {
            multiPicker()
        } else {
            singlePicker()
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        toggleSwitch.addTarget(self, action: #selector(toggleAction), for: .valueChanged)
    }
    
    @objc func toggleAction() {
        isOn = toggleSwitch.isOn
        if toggleSwitch.isOn {
            contentLbl.text = "Multi Component Picker"
        } else {
            contentLbl.text = "Single Component Picker"
        }
        
    }

    
//    @IBAction func toggleSwitch(_ sender: UISwitch) {
//        isOn = sender.isOn
//        if sender.isOn {
////            selectionLbl.text = "Multi Component Picker"
//        } else {
////            selectionLbl.text = "Single Component Picker"
//        }
//    }
    
//    @IBAction func button(_ sender: UIButton) {
//        if isOn {
//            multiPicker()
//        } else {
//            singlePicker()
//        }
//    }
    
    
    func multiPicker() {
        
        let months = (1...12).map { String(format: "%02d", $0) }
        let currentYear = Calendar.current.component(.year, from: Date())
        let years = (currentYear...(currentYear + 10)).map(String.init)
        
        let datePicker = MJPickerView(
            componentItems: [months,years],
            delegate: self) { values in
                debugPrint(values.joined(separator: "/"))
            }
        datePicker.show(in: view)
    }
    
    func singlePicker() {
        
        let months = (1...12).map { String(format: "%02d", $0) }
        
        let datePicker = MJPickerView(
            componentItems: [months],
            delegate: self) { values in
                debugPrint(values.joined(separator: "/"))
            }
        datePicker.show(in: view)
    }


}

extension ViewController: MJPickerDelegate {
    
    func didSelectItems(_ items: [String]) {
        debugPrint(items.joined(separator: "/"))
    }
    
}

