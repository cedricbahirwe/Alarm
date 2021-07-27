//
//  TimerView.swift
//  Alarmo
//
//  Created by Cédric Bahirwe on 27/07/2021.
//

import SwiftUI

class TimerManager: ObservableObject {
    
    @Published var hourSelection = 0
    @Published var minuteSelection = 0
    @Published var secondSelection = 0
        
    var hours = [Int](0..<24)
    var minutes = [Int](0..<60)
    var seconds = [Int](0..<60)
    
    var counterText: String = ""
    var counter = 0
    var datas = [[Int]]()
    var timer = Timer()
    
    init() {
    }
    
    private func startCounting() {
        self.timer.invalidate()
        self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.upCountTimer), userInfo: nil, repeats: true)
//        self.timer.tolerance = 0.1
    }
    
    @objc func upCountTimer() {
        counter -= 1
        if counter == 0 {
            timer.invalidate()
        } else {
            counterText = getReadableTimeFormat(amount: counter, type: "i")
        }
    }
    
    public func startTimer() {
//        let duration = ((hr * 3600) + (min * 60) + sec)
        
//        counter = duration
        startCounting()
    }
    
    
}

struct TimerView: View {
    private let size = UIScreen.main.bounds.size
    
    @StateObject private var timerData = TimerManager()
    
    var body: some View {
        VStack {
            
            GeometryReader { geometry in
                HStack(spacing: 0) {
                    Picker("", selection: $timerData.hourSelection) {
                        ForEach(0 ..< timerData.hours.count) { index in
                            Text(String(format: "%02d",timerData.hours[index])).tag(index)
                        }
                    }
                    .frame(width: geometry.size.width/3, height: 100, alignment: .center)
                    .clipped()
                    Picker(selection: $timerData.minuteSelection, label: Text("")) {
                        ForEach(0 ..< timerData.minutes.count) { index in
                            Text(String(format: "%02d",timerData.minutes[index])).tag(index)
                        }
                    }
                    .frame(width: geometry.size.width/3, height: 100, alignment: .center)
                    .clipped()
                    Picker(selection: $timerData.secondSelection, label: Text("")) {
                        ForEach(0 ..< timerData.seconds.count) { index in
                            Text(String(format: "%02d",timerData.seconds[index])).tag(index)
                                .font(.system(size: 20, weight: .bold))
                        }
                    }
                    .frame(width: geometry.size.width/3, height: 100, alignment: .center)
//                    .clipped()
                }
            }
            .frame(height: 200, alignment: .bottom)
            .background(Color.red)
            .overlay(
                HStack {
                    Text("Hours")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("Minutes")
                        .frame(maxWidth: .infinity)
                    Text("Seconds")
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }
                .foregroundColor(.secondary)
                , alignment: .top
            )
            .padding(10)

            
            Spacer()
            HStack(spacing: 60) {
                Button(action: {
                }, label: {
                    Text( "Start")
                        .font(.uiFont(name: .noteworthy, size: 20))
                        .bold()
                        .foregroundColor(.white)
                        .frame(width: 120, height: 45)
                        .background(Color.blue)
                        .clipShape(Capsule())

                })

                Button(action: {

                }, label: {
                    Text("Cancel")
                        .font(.uiFont(name: .noteworthy, size: 20))
                        .bold()
                        .foregroundColor(.white)
                        .frame(width: 120, height: 45)
                        .background(Color(.darkGray))
                        .clipShape(Capsule())
                        .transition(.move(edge: .trailing))

                })
            }
            .padding(.bottom, 40)
            .padding(.top)
            .animation(.spring())
            
        }
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView()
            .preferredColorScheme(.dark)
    }
}



struct CustomPickerView: UIViewRepresentable {
    func makeUIView(context: Context) -> some UIView {
        
    }
    
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        <#code#>
    }
}
