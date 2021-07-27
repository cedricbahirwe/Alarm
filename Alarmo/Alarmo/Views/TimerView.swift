//
//  TimerView.swift
//  Alarmo
//
//  Created by Cédric Bahirwe on 27/07/2021.
//

import SwiftUI



let timer = Timer
    .publish(every: 1, on: .main, in: .common)
    .autoconnect()

struct TimerView: View {
    
    @StateObject private var timerData = TimerManager()
    var body: some View {
        VStack {
            Group {
                if timerData.timerState == .initial {
                    CustomPickerView(hr: $timerData.hr,
                                     min: $timerData.min,
                                     sec: $timerData.sec)
                        .frame(height: 200)
                        .overlay(colonView)
                        .overlay(pickerHeaderView, alignment: .top)
                } else {
                    CountdownView(countTo: timerData.duration)
                        .frame(width: 270, height: 270)
                }
            }
            .padding(.top, 100)
            
            Spacer()
            HStack(spacing: 60) {
                Button(action: {
                    timerData.timerState = .running
                }, label: {
                    Text( "Start")
                        .font(.uiFont(name: .noteworthy, size: 20))
                        .bold()
                        .foregroundColor(.white)
                        .frame(width: 120, height: 45)
                        .background(Color.blue)
                        .clipShape(Capsule())
                })
                .opacity(timerData.canStartTimer ? 1 : 0.5)
                .disabled(timerData.canStartTimer == false)
                
                Button(action: {
                    timerData.timerState = .initial
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
    struct Clock: View {
        var counter: Int
        var countTo: Int
        
        var body: some View {
            VStack {
                Text(counterToMinutes())
                    .font(.custom("Avenir Next", size: 60))
                    .fontWeight(.black)
                    .lineLimit(1)
                    .minimumScaleFactor(0.5)
            }
        }
        
        func counterToMinutes() -> String {
            let currentTime = countTo - counter
            return getReadableTimeFormat(amount: currentTime, type: "i")
        }
    }
    
    
    struct ProgressTrack: View {
        var body: some View {
            Circle()
                .fill(Color.clear)
                .overlay(
                    Circle().stroke(Color.primary.opacity(0.2),
                                    lineWidth: 15)
                )
        }
    }
    
    struct ProgressBar: View {
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
            progress() == 1
        }
        
        func progress() -> CGFloat {
            (CGFloat(counter) / CGFloat(countTo))
        }
    }
    
    struct CountdownView: View {
        @State var counter: Int = 0
        var countTo: Int = 120
        
        var body: some View {
            VStack{
                ZStack{
                    ProgressTrack()
                    ProgressBar(counter: counter, countTo: countTo)
                    Clock(counter: counter, countTo: countTo)
                        .padding(15) // For the border width
                }
            }.onReceive(timer) { time in
                if (self.counter < self.countTo) {
                    self.counter += 1
                }
            }
        }
    }
    
}

