//
//  MJPicker.swift
//  MJPicker
//
//  Created by maroleanj on 06/12/24.
//

import UIKit


//Done button will already pass the items but if you are using Picker Did select row you can utilize this
protocol MJPickerDelegate: AnyObject {
    func didSelectItems(_ items: [String])
}

class MJPickerView: UIView {

    private let pickerBackground = UIView()
    private let itemSelectionView = UIView()
    private let pgPickerView = UIPickerView()
    private let barAccessory = UIToolbar()
    
    private let componentItems: [[String]]
    weak var delegate: MJPickerDelegate?
    
    private var onDone: (([String]) -> Void)?
    
    init(componentItems: [[String]], delegate: MJPickerDelegate? = nil, onDone: (([String]) -> Void)? = nil) {
        self.componentItems = componentItems
        self.delegate = delegate
        self.onDone = onDone
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        pickerBackground.translatesAutoresizingMaskIntoConstraints = false
        pickerBackground.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        
        itemSelectionView.translatesAutoresizingMaskIntoConstraints = false
        itemSelectionView.backgroundColor = UIColor.white
        
        let done = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonTapped))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        barAccessory.translatesAutoresizingMaskIntoConstraints = false
        barAccessory.barStyle = .default
        barAccessory.isTranslucent = false
        done.tintColor = UIColor.systemBlue
        barAccessory.items = [flexibleSpace, done]
        barAccessory.backgroundColor = UIColor.lightGray
        barAccessory.sizeToFit()
        
        pgPickerView.translatesAutoresizingMaskIntoConstraints = false
        pgPickerView.delegate = self
        pgPickerView.dataSource = self
        pgPickerView.backgroundColor = UIColor.white
        
        addSubview(pickerBackground)
        itemSelectionView.addSubview(pgPickerView)
        itemSelectionView.addSubview(barAccessory)
        pickerBackground.addSubview(itemSelectionView)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            pickerBackground.topAnchor.constraint(equalTo: topAnchor),
            pickerBackground.bottomAnchor.constraint(equalTo: bottomAnchor),
            pickerBackground.leadingAnchor.constraint(equalTo: leadingAnchor),
            pickerBackground.trailingAnchor.constraint(equalTo: trailingAnchor),

            itemSelectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            itemSelectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            itemSelectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            itemSelectionView.heightAnchor.constraint(equalToConstant: 300),
            
            barAccessory.topAnchor.constraint(equalTo: itemSelectionView.topAnchor),
            barAccessory.leadingAnchor.constraint(equalTo: itemSelectionView.leadingAnchor),
            barAccessory.trailingAnchor.constraint(equalTo: itemSelectionView.trailingAnchor),
            barAccessory.heightAnchor.constraint(equalToConstant: 44),
            
            pgPickerView.topAnchor.constraint(equalTo: barAccessory.bottomAnchor),
            pgPickerView.leadingAnchor.constraint(equalTo: itemSelectionView.leadingAnchor),
            pgPickerView.trailingAnchor.constraint(equalTo: itemSelectionView.trailingAnchor),
            pgPickerView.bottomAnchor.constraint(equalTo: itemSelectionView.bottomAnchor, constant: -40)
        ])
    }
    
    func show(in view: UIView) {
        view.addSubview(self)
        
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: view.topAnchor),
            bottomAnchor.constraint(equalTo: view.bottomAnchor),
            leadingAnchor.constraint(equalTo: view.leadingAnchor),
            trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        itemSelectionView.alpha = 0
        UIView.animate(withDuration: 0.3) {
            self.pickerBackground.backgroundColor = UIColor.black.withAlphaComponent(0.6)
            self.itemSelectionView.alpha = 1
        }
        
        pgPickerView.selectRow(0, inComponent: 0, animated: false)
    }
    
    private func hide() {
        UIView.animate(withDuration: 0.3) {
            self.pickerBackground.backgroundColor = .clear
            self.itemSelectionView.alpha = 0
        } completion: { _ in
            self.removeFromSuperview()
        }
    }
    
    @objc private func doneButtonTapped() {
        var selectedItems: [String] = []
        for component in 0..<componentItems.count {
            let selectedRow = pgPickerView.selectedRow(inComponent: component)
            selectedItems.append(componentItems[component][selectedRow])
        }

        delegate?.didSelectItems(selectedItems)
        onDone?(selectedItems)
        hide()
    }
}

// MARK: - UIPickerView Delegate and DataSource
extension MJPickerView: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int { componentItems.count
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return componentItems[component].count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return componentItems[component][row]
    }
    
}
