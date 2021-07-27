//
//  ContentView.swift
//  Alarmo
//
//  Created by Cédric Bahirwe on 27/07/2021.
//

import SwiftUI

struct ContentView: View {
    
    @AppStorage("selectedTab")
    private var selectedTab: Int = 2
    var body: some View {
        TabView(selection: $selectedTab) {
            RemindersView()
                .tabItem {
                    Label("Reminds", systemImage: "calendar")
                }.tag(1)
            
            AlarmsView()
                .tabItem {
                    Label("Alarms", systemImage: "alarm.fill")
                }.tag(2)
            
            StopWatchView()
                .tabItem {
                    Label("StopWatch", systemImage: "stopwatch.fill")
                }.tag(3)
            
            TimerView()
                .tabItem {
                    Label("Timer", systemImage: "timer")
                }.tag(4)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
