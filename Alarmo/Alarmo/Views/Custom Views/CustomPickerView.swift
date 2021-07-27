//
//  CustomPickerView.swift
//  Alarmo
//
//  Created by Cédric Bahirwe on 27/07/2021.
//

import SwiftUI

struct CustomPickerView: UIViewRepresentable {
    @Binding var hr: Int
    @Binding var min: Int
    @Binding var sec: Int
    
    var hours: [Int] = Array(00...99)
    var minutes: [Int] = Array(00...59)
    var secondes: [Int] = Array(00...59)
    func makeUIView(context: Context) -> UIPickerView {
        
        let pickerView = UIPickerView()
        pickerView.delegate = context.coordinator
        pickerView.dataSource = context.coordinator
        
        pickerView.selectRow(hours.count / 2, inComponent: 0, animated: true)
        pickerView.selectRow(minutes.count / 2, inComponent: 1, animated: true)
        pickerView.selectRow(secondes.count / 2, inComponent: 2, animated: true)
        
        return pickerView
    }
    
    
    func updateUIView(_ uiView: UIPickerView, context: Context) {
        // Animte only when the view is initialize
        if hr + min + sec == 0 {
            uiView.selectRow(0, inComponent: 0, animated: true)
            uiView.selectRow(0, inComponent: 1, animated: true)
            uiView.selectRow(0, inComponent: 2, animated: true)
        }
    }
    
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, UIPickerViewDelegate, UIPickerViewDataSource {
        
        
        var parent: CustomPickerView
        let datas: [[Int]]
        init(_ parent: CustomPickerView) {
            self.parent = parent
            datas =  [parent.hours, parent.minutes, parent.secondes]
        }
        
        func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            return datas[component].count
        }
        func numberOfComponents(in pickerView: UIPickerView) -> Int {
            return datas.count
        }
        
        func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
            let label = UILabel()
            label.frame.origin = CGPoint(x: 0, y: 0)
            // self.pickerView.frame.width / 3
            //            label.frame.size = CGSize(width: 120 , height: 90)
            label.font = .systemFont(ofSize: 40, weight: .semibold)
            label.textColor = .label
            label.textAlignment = component == 0 ?  .left : component == 1 ? .center : .right
            label.text = String(format: "%02d", datas[component][row])
            
            return label
        }
        
        func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
            return 80.0
        }
        
        
        func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
            return 80
        }
        
        
        func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            if component == 0 {
                parent.hr = parent.hours[row]
            } else if component == 1 {
                parent.min = parent.minutes[row]
            } else if component == 2 {
                parent.sec = parent.secondes[row]
            }
        }
        
    }
}
