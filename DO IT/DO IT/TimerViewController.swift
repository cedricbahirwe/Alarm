//
//  TimerViewController.swift
//  DO IT
//
//  Created by Cedric Bahirwe on 8/1/20.
//  Copyright © 2020 Cedric Bahirwe. All rights reserved.
//

import UIKit

class TimerViewController: UIViewController {
    
    @IBOutlet weak var backView: MonochromeView!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    var (hr, min, sec) = (0,0,0)
    var counter = 0
    
    @IBOutlet weak var containerView: MonochromeView!
    var hours: [Int] = Array(00...99)
    var minutes: [Int] = Array(00...59)
    var secondes: [Int] = Array(00...59)
    var datas = [[Int]]()
    var timer = Timer()
    @IBOutlet weak var pickerView: UIPickerView!
    override func viewDidLoad() {
        super.viewDidLoad()
        datas.append(contentsOf: [hours, minutes, secondes])
        pickerView.delegate = self
        pickerView.dataSource = self
        setupLayout()
        self.pickerView.selectRow(hours.count / 2, inComponent: 0, animated: true)
        self.pickerView.selectRow(minutes.count / 2, inComponent: 1, animated: true)
        self.pickerView.selectRow(secondes.count / 2, inComponent: 2, animated: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.pickerView.selectRow(0, inComponent: 0, animated: true)
        self.pickerView.selectRow(0, inComponent: 1, animated: true)
        self.pickerView.selectRow(0, inComponent: 2, animated: true)
    }
    
    func setupLayout() {
        self.startButton.layer.cornerRadius = self.startButton.frame.height / 2
        self.cancelButton.layer.cornerRadius = self.cancelButton.frame.height / 2
        self.cancelButton.isHidden = true
        self.startButton.isEnabled = false
        self.startButton.backgroundColor = UIColor.systemBlue.withAlphaComponent(0.5)
    }
    
    func startCount() {
        self.timer.invalidate()
        self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.upCountTimer), userInfo: nil, repeats: true)
//        self.timer.tolerance = 0.1
    }
    
    @objc func upCountTimer() {
        counter -= 1
        if timerLabel.text == "00:00:00" {
            timer.invalidate()
        } else {
            timerLabel.text = getReadableTimeFormat(amount: counter, type: "i")
        }
    }
    
    func getReadableTimeFormat(amount: Int, type: String) -> String {
        let (hrs, minsec) = amount.quotientAndRemainder(dividingBy: 3600)
        let (min, sec) = minsec.quotientAndRemainder(dividingBy: 60)
        return type == "s" ? "\(hrs)h:\(min)m" : "\(String(format: "%02d", hrs)):\(String(format: "%02d", min)):\(String(format: "%02d", sec))"
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func didPressStart(_ sender: UIButton) {
        let duration = ((self.hr * 3600) + (self.min * 60) + self.sec)
        counter = duration
        if sender.titleLabel?.text == "Start" {
            self.mainView.isHidden = true
            self.containerView.isHidden = false
            self.backView.isHidden = false
            self.startButton.setTitle("Pause", for: .normal)
            self.startButton.backgroundColor = UIColor.systemRed.withAlphaComponent(0.5)
            self.backView.animationDuration = 0.1
            self.backView.data.color = UIColor.gray.withAlphaComponent(0.6)
            self.backView.configureView(with: 1.0)
            self.containerView.animationDuration = Double(duration)
            self.startCount() //
            self.containerView.configureView(with: 1.0)
            self.cancelButton.isHidden = false
        } else if sender.titleLabel?.text == "Pause" {

        } else if sender.titleLabel?.text == "Resume" {

        }
    }
    
    @IBAction func didpressCancel(_ sender: UIButton) {
        self.cancelButton.isHidden = true
        UIView.animate(withDuration: 0.3) {
            self.containerView.animationDuration = 0.1
            self.containerView.configureView(with: 0.1)

            self.mainView.isHidden = false
            self.containerView.isHidden = true
            self.backView.isHidden = true
            self.startButton.setTitle("Start", for: .normal)
            self.startButton.backgroundColor = UIColor.systemBlue
        }
    }
}


extension TimerViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return datas[component].count
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        pickerView.subviews[1].backgroundColor = .clear
        pickerView.subviews[2].backgroundColor = .clear
        let label = UILabel()
        label.frame.origin = CGPoint(x: 0, y: 0)
        label.frame.size = CGSize(width: self.pickerView.frame.width / 3, height: 90)
        label.font = .systemFont(ofSize: 40, weight: .semibold)
        label.textColor = .white
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
            hr = hours[row]
        } else if component == 1 {
            min = minutes[row]
        } else if component == 2 {
            sec = secondes[row]
        }
                
        if hr == 0 && min == 0 && sec == 0 {
            startButton.isEnabled = false
            self.startButton.backgroundColor = UIColor.systemBlue.withAlphaComponent(0.5)
        } else {
            startButton.isEnabled = true
            self.startButton.backgroundColor = UIColor.systemBlue.withAlphaComponent(1)
        }
        
    }

}
