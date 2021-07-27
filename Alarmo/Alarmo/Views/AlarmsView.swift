//
//  AlarmsView.swift
//  Alarmo
//
//  Created by Cédric Bahirwe on 27/07/2021.
//

import SwiftUI

struct AlarmsView: View {
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    ForEach(00..<25, content: AlarmRowView.init)
                }
            }
            .padding(.horizontal, 8)
            .navigationTitle("Alarms")
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    
                    Button(action: {}, label: {
                        Image(systemName: "plus")
                    })
                    
                    Button(action: {}, label: {
                        Text("More")
                    })
                }
            }
        }
    }
}

struct AlarmsView_Previews: PreviewProvider {
    static var previews: some View {
        AlarmsView()
        //            .preferredColorScheme(.dark)
    }
}
extension AlarmsView {
    
    struct AlarmRowView: View {
        let hour: String
        
        init(_ i: Int) {
            hour = i < 10 ? "0\(i)" : i.description
        }
        var body: some View {
            HStack {
                VStack(alignment: .leading) {
                    Text("Wake Up")
                        .font(.system(size: 14, weight: .medium))
                    Text("\(hour):00")
                        .font(.system(size: 30, weight: .medium))
                    
                }
                Spacer()
                HStack {
                    Text("M T W T F S S")
                        .font(.system(size: 14))
                        .foregroundColor(.lightGreen)
                    Toggle("", isOn: .constant(true))
                        .labelsHidden()
                        .toggleStyle(SwitchToggleStyle(tint: .lightGreen))
                }
            }
            .padding()
            .background(Color(.tertiarySystemFill))
            .cornerRadius(15)
        }
    }
}
