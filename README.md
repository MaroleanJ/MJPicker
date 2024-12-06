# MJPicker
A simple picker that can be utilised in less number of codes which supports single and multi component

Just drag and drop the MJPicker.swift file and use it in your application


# Sample Screenshot of single component Picker

# Sample Screenshot of multi component Picker


# Requirements
iOS 12.0


Xcode 13.0+
Swift 5.0+

# MJPicker Usage
In your ViewController to open MJPickerView just use like the below
```Swift
    func openPicker() {
        
        let months = (1...12).map { String(format: "%02d", $0) }
        
        let datePicker = MJPickerView(
            componentItems: [months],
            delegate: self) { values in
                debugPrint(values.joined(separator: "/"))
            }
        datePicker.show(in: view)
    }

    @IBAction func butttonAction(_ sender: UIButton) {
        openPicker()
    }


```
to close MJPickerView just press **Done** on the picker view's toolbar

# Author
Marolean James
