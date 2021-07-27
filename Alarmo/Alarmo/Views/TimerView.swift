//
//  TimerView.swift
//  Alarmo
//
//  Created by Cédric Bahirwe on 27/07/2021.
//

import SwiftUI

struct TimerView: View {
    
    @StateObject private var timerData = TimerManager()
    @State private var finishedCountDown = false
    @State private var counter = 0
    var body: some View {
        VStack {
            Group {
                if timerData.timerState == .initial {
                    CustomPickerView(hr: $timerData.hr,
                                     min: $timerData.min,
                                     sec: $timerData.sec)
                        .frame(height: 230)
                        .overlay(colonView)
                        .overlay(pickerHeaderView, alignment: .top)
                } else {
                    CountdownView
                        .frame(width: 270, height: 270)
                }
            }
            .padding(.top, 100)
            Spacer()
            HStack(spacing: 60) {
                let state = timerData.timerState
                
                if !(finishedCountDown && state == .running) {
                    Button(action: {
                        timerData.manageTimer()
                    }, label: {
                        Text(state == .running  ? "Pause" : state == .paused ? "Resume" : "Start")
                            .font(.uiFont(name: .noteworthy, size: 20))
                            .bold()
                            .foregroundColor(.white)
                            .frame(width: 120, height: 45)
                            .background(timerData.timerState == .initial ? Color.blue : .red)
                            .clipShape(Capsule())
                    })
                    .opacity(timerData.canStartTimer ? 1 : 0.5)
                    .disabled(timerData.canStartTimer == false)
                }
                
                Button(action: {
                    counter = 0
                    timerData.resetTimer()
                }, label: {
                    Text(finishedCountDown ? "Reset" : "Cancel")
                        .font(.uiFont(name: .noteworthy, size: 20))
                        .bold()
                        .foregroundColor(.white)
                        .frame(width: 120, height: 45)
                        .background(Color(.darkGray))
                        .clipShape(Capsule())
                        .transition(.move(edge: .trailing))
                })
            }
            .animation(.spring())
            Spacer()
            
        }
    }
    
    private var pickerHeaderView: some View {
        HStack {
            Text("Hours")
                .frame(maxWidth: .infinity)
            Text("Minutes")
                .frame(maxWidth: .infinity)
            Text("Seconds")
                .frame(maxWidth: .infinity)
        }
        .foregroundColor(.secondary)
    }
    
    private var colonView: some View {
        HStack(spacing: -10) {
            Text(":")
                .frame(maxWidth: .infinity, alignment: .trailing)
            Text("00")
                .frame(maxWidth: .infinity)
                .hidden()
            Text(":")
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .font(.system(size: 40, weight: .semibold))
        .offset(y: -5)
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView()
            .preferredColorScheme(.dark)
    }
}

extension TimerView {
    private var CountdownView: some View {
        VStack{
            ZStack{
                Circle()
                    .fill(Color.clear)
                    .overlay(
                        Circle().stroke(Color.primary.opacity(0.2),
                                        lineWidth: 15)
                    )
                ProgressBarView(isFinished: $finishedCountDown,
                                counter: counter,
                                countTo: timerData.duration)
                VStack {
                    Text(counterToSeconds())
                        .font(.custom("Avenir Next", size: 60))
                        .fontWeight(.black)
                        .lineLimit(1)
                        .minimumScaleFactor(0.5)
                }
                .padding(15) // For the border width
            }
        }
        .onReceive(timerData.timer) { _ in
            if (counter < timerData.duration) {
                counter += 1
            }
        }
    }
    
    func counterToSeconds() -> String {
        let currentTime = timerData.duration - counter
        return getReadableTimeFormat(amount: currentTime, type: "i")
    }
}

struct ProgressBarView: View {
    @Binding var isFinished: Bool
    var counter: Int
    var countTo: Int
    
    var body: some View {
        Circle()
            .fill(Color.clear)
            .overlay(
                Circle().trim(from:0, to: progress())
                    .stroke(
                        style: StrokeStyle(
                            lineWidth: 15,
                            lineCap: .round,
                            lineJoin:.round
                        )
                    )
                    .foregroundColor(
                        (completed() ? Color.lightGreen : Color.orange)
                    )
                    .animation(
                        .easeInOut(duration: 0.2)
                    )
            )
    }
    
    func completed() -> Bool {
        isFinished = progress() == 1
        return isFinished
    }
    
    func progress() -> CGFloat {
        (CGFloat(counter) / CGFloat(countTo))
    }
}

