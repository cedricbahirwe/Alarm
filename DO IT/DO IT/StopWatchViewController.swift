//
//  StopWatchViewController.swift
//  DO IT
//
//  Created by Cedric Bahirwe on 8/1/20.
//  Copyright © 2020 Cedric Bahirwe. All rights reserved.
//

import UIKit

struct Values {
    var lapCount = Int()
    var lapTimes = String()
    var overallTime = String()
}

class StopWatchViewController: UIViewController {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    var data: [Values] = []
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    @IBOutlet weak var lapTimerLabel: UILabel!
    @IBOutlet weak var buttonsStackView: UIStackView!
    @IBOutlet weak var startStopButton: UIButton!
    @IBOutlet weak var lapResetButton: UIButton!
    var timerA = Timer()
    var laps = 0
    var counter = 0
    var counterB = 0
    var firstButtonTtitle = "Start" {
        didSet {
            self.startStopButton.setTitle(firstButtonTtitle, for: .normal)
        }
    }
    var secondButtonTitle = "Lap" {
        didSet {
            self.lapResetButton.setTitle(secondButtonTitle, for: .normal)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 55.0
        startStopButton.layer.cornerRadius = self.startStopButton.frame.height / 2
        lapResetButton.layer.cornerRadius = self.lapResetButton.frame.height / 2
        self.lapResetButton.isHidden = true
    }
    
    @IBAction func didPressStart_Stop(_ sender: UIButton) {
        if firstButtonTtitle == "Start" {
            self.startCountA()
            UIView.animate(withDuration: 0.2) {
                self.lapResetButton.isHidden = false
                self.startStopButton.backgroundColor = UIColor.red.withAlphaComponent(0.5)
                self.firstButtonTtitle = "Stop"
            }
            
        }else if firstButtonTtitle == "Stop" {
            self.timerA.invalidate()
            self.startStopButton.backgroundColor = UIColor.systemBlue.withAlphaComponent(0.5)
            self.firstButtonTtitle = "Resume"
            self.secondButtonTitle = "Reset"
            
        } else if firstButtonTtitle == "Resume" {
            self.timerA.invalidate()
            self.timerA = Timer.scheduledTimer(timeInterval: 0.9, target: self, selector: #selector(self.upCountTimer), userInfo: nil, repeats: true)
            self.startStopButton.backgroundColor = UIColor.red.withAlphaComponent(0.5)
            self.firstButtonTtitle = "Stop"
            self.secondButtonTitle = "Lap"
        }

    }
    
    @IBAction func didPresslap_Reset(_ sender: UIButton) {
        if secondButtonTitle == "Lap" {
            self.topConstraint.constant = 65
            self.laps += 1
            
            UIView.animate(withDuration: 0.3) {
                self.view.layoutIfNeeded()
                self.lapTimerLabel.isHidden = false
                self.containerView.isHidden = false
                self.containerView.alpha = 1
            }
            let value = Values(lapCount: self.laps, lapTimes: self.lapTimerLabel.text!, overallTime: self.timerLabel.text!)
            counterB  = 0
            data.insert(value, at: 0)
            tableView.beginUpdates()
            tableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .fade)
            tableView.endUpdates()
            tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
            
        } else if secondButtonTitle == "Reset" {
            counter = 0
            self.timerLabel.text = "00:00:00"
            self.lapResetButton.isHidden = true
            firstButtonTtitle = "Start"
            secondButtonTitle = "Lap"
            
            self.topConstraint.constant = 100
            UIView.animate(withDuration: 0.3) {
                self.view.layoutIfNeeded()
                self.lapTimerLabel.isHidden = true
                self.containerView.isHidden = true
                self.containerView.alpha = 0.5
                self.data = []
                self.tableView.reloadData()
            }
        }
    }
    
    func startCountA() {
        self.timerA.invalidate()
        self.timerA = Timer.scheduledTimer(timeInterval: 0.9, target: self, selector: #selector(self.upCountTimer), userInfo: nil, repeats: true)
        self.timerA.tolerance = 0.1
    }
    
    @objc func upCountTimer() {
        counter += 1
        counterB += 1
        timerLabel.text = getReadableTimeFormat(amount: counter, type: "i")
        lapTimerLabel.text = getReadableTimeFormat(amount: counterB, type: "i")
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

}
extension StopWatchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "LapTimeTableViewCell", for: indexPath) as? LapTimeTableViewCell else { return UITableViewCell() }
        cell.lapCount.text = String(format: "%02d", data[indexPath.row].lapCount)
        cell.lapTimeLabel.text = data[indexPath.row].lapTimes
        cell.overallTimeLabel.text = data[indexPath.row].overallTime
        return cell
    }
    
}
