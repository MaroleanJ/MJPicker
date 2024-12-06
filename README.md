# MJPicker
A simple picker that can be utilised in less number of codes which supports single and multi component

Just drag and drop the MJPicker.swift file and use it in your application


# Sample Screenshot of single component Picker
<img width="348" alt="Single_Component_Picker" src="https://github.com/user-attachments/assets/47552d82-9c95-4be8-b4ae-0994affd5cd5">

# Sample Screenshot of multi component Picker
<img width="354" alt="Multi_Component_Picker" src="https://github.com/user-attachments/assets/1b7dd236-1fc6-4f3a-80aa-2bddc5504824">

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
