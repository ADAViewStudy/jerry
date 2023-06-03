//
//  CustomPicker.swift
//  AlarmCL
//
//  Created by 주환 on 2023/06/03.
//

import SwiftUI

struct CustomPicker: UIViewRepresentable {
    let sec: Binding<Double>
    
    func makeUIView(context: Context) -> UIPickerView {
        let pickerView = UIPickerView(frame: .zero)
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        pickerView.delegate = context.coordinator
        pickerView.dataSource = context.coordinator
        return pickerView
    }
    
    func updateUIView(_ uiView: UIPickerView, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(sec: sec)
    }
    
    final class Coordinator: NSObject, UIPickerViewDataSource, UIPickerViewDelegate {
        let sec: Binding<Double>
        let values: [Int] = Array(0..<100)
        
        init(sec: Binding<Double>) {
            self.sec = sec
        }
        
        func numberOfComponents(in pickerView: UIPickerView) -> Int {
            return 3
        }
        
        func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            return component == 0 ? 24 : 60
        }
        
        func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            if component == 0 {
                return "\(values[row])"
            }
            else {
                return "\(values[row])"
            }
        }
        
        func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            let hourIndex = pickerView.selectedRow(inComponent: 0)
            let minIndex = pickerView.selectedRow(inComponent: 1)
            let secIndex = pickerView.selectedRow(inComponent: 2)
            
            sec.wrappedValue = Double(secIndex+(minIndex*60)+(hourIndex*360))
        }
    }
}


//struct CustomPicker_Previews: PreviewProvider {
//    static var previews: some View {
//        CustomPicker()
//    }
//}
