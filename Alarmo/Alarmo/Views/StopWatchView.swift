//
//  StopWatchView.swift
//  Alarmo
//
//  Created by Cédric Bahirwe on 27/07/2021.
//

import SwiftUI


extension Font {
    public enum CustomFont: String {
        case noteworthy = "Noteworthy"
    }
    public static func uiFont(name: CustomFont, size: CGFloat) -> Font {
        Font(UIFont(name: name.rawValue, size: size)!)
    }
}

struct Lap: Identifiable {
    let id = UUID()
    var count = Int()
    var time = String()
    var overallTime = String()
}
struct StopWatchView: View {
    @State private var laps: [Lap] = []

    @StateObject private var timerData = TimerManger()
    
    var body: some View {
        VStack {
            VStack {
                Text(timerData.mainTimerText)
                    .font(.uiFont(name: .noteworthy, size: 40))
                    .bold()
                    .fixedSize()
//                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                
                Text(timerData.lapTimerText)
                    .font(.uiFont(name: .noteworthy, size: 20))
                    .bold()
                    .foregroundColor(Color(.darkGray))
                    .opacity(laps.isEmpty ? 0 : 1)
                    .animation(.linear(duration: 0.3))
            }
            .padding(.top, laps.isEmpty ? 100 : 65)
            .animation(.linear(duration: 0.3))
            
            VStack {
                HStack {
                    Text("Lap")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("Lap times")
                        .frame(maxWidth: .infinity)
                    Text("Overall time")
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }
                .font(.system(size: 16))
                .foregroundColor(.gray)
                
                Divider()
                ScrollView {
                    VStack {
                        ForEach(laps) { lap in
                            HStack {
                                Text(String(format: "%02d", lap.count))
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                Text(lap.time)
                                    .frame(maxWidth: .infinity)
                                Text(lap.overallTime)
                                    .frame(maxWidth: .infinity, alignment: .trailing)
                            }
                            .foregroundColor(Color.secondary)
                            .frame(height: 40)
                        }
                    }
                }
            }
            .padding(20)
            .opacity(laps.isEmpty ? 0 : 1)
            
            
            HStack(spacing: 60) {
                let state = timerData.timerState
                Button(action: {
                    withAnimation(.linear) {
                        timerData.startStopTimer()
                    }
                }, label: {
                    Text(state == .running  ? "Pause" : state == .paused ? "Resume" : "Start")
                        .font(.uiFont(name: .noteworthy, size: 20))
                        .bold()
                        .foregroundColor(Color(.systemBackground))
                        .frame(width: 120, height: 45)
                        .background(
                            Group {
                                switch state {
                                case .running: Color.red
                                case .paused: Color.green
                                default: Color.blue
                                }
                            }
                        )
                        .clipShape(Capsule())
                    
                })
                
                if state != .initial {
                    Button(action: {
                        withAnimation(.linear) {
                            if state == .paused {
                                timerData.resetCounter()
                            } else {
                                timerData.lapCounter = 0
                                let lap = Lap(count: laps.count+1,
                                              time: timerData.lapTimerText,
                                              overallTime: timerData.mainTimerText)
                                
                                laps.insert(lap, at: 0)
                                
                            }
                        }
                    }, label: {
                        Text(state == .paused ? "Reset" : "Lap")
                            .font(.uiFont(name: .noteworthy, size: 20))
                            .bold()
                            .foregroundColor(Color(.systemBackground))
                            .frame(width: 120, height: 45)
                            .background(Color(.darkGray))
                            .clipShape(Capsule())
                            .transition(.move(edge: .trailing))

                    })
                }
            }
            .padding(.bottom, 30)
            .padding(.top)
            .animation(.spring())
        }
        .overlay(
            Button(action: {}, label: {
                Text("More")
                    .padding(8)
            })
            , alignment: .topTrailing
        )
        
    }
}

struct StopWatchView_Previews: PreviewProvider {
    static var previews: some View {
        StopWatchView()
            .preferredColorScheme(.dark)
    }
}

class TimerManger: ObservableObject {
    enum TimerState { case running, paused, initial }
    @Published private(set) var timerState:TimerState = .initial
    @Published private(set) var generalCounter = 0
    @Published private(set) var mainTimerText = "00:00:00"
    @Published private(set) var lapTimerText = "00:00:00"
    
    private var timer = Timer()
    
    @Published var lapCounter = 0

    public func startStopTimer() {
        if timerState == .running  {
            pauseCounter()
        } else {
            startCounter()
        }
    }
    
    public func resetCounter() {
        timer.invalidate()
        timerState = .initial
    }
    
    private func startCounter() {
        timerState = .running
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { _ in self.updateCounting()
        })
    }
    
    private func updateCounting() {
        generalCounter += 1
        lapCounter += 1
        mainTimerText = getReadableTimeFormat(amount: generalCounter, type: "i")
        lapTimerText = getReadableTimeFormat(amount: lapCounter, type: "i")
    }
    
    private func pauseCounter() {
        timer.invalidate()
        timerState = .paused
    }

}
extension TimerManger {
    
    private func getReadableTimeFormat(amount: Int, type: String) -> String {
        let (hrs, minsec) = amount.quotientAndRemainder(dividingBy: 3600)
        let (min, sec) = minsec.quotientAndRemainder(dividingBy: 60)
        return type == "s" ? "\(hrs)h:\(min)m" : "\(String(format: "%02d", hrs)):\(String(format: "%02d", min)):\(String(format: "%02d", sec))"
    }
    
}
