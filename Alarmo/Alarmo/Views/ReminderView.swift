//
//  ReminderView.swift
//  Alarmo
//
//  Created by Cédric Bahirwe on 27/07/2021.
//

import SwiftUI


struct Reminder: Identifiable, Hashable {
    let id: Int
    let date = Date()
    static let examples:[Reminder] = [1,2,3,4,5,6,7,8,9,0,1,423,23,5,35,43,6,6,457,45,756,78,45,745].map{ Reminder(id: $0) }
    
}
struct ReminderView: View {
    @State private var reminders = Reminder.examples
        @State var editMode = EditMode.inactive
        @State var selection = Set<Reminder>()
    var body: some View {
        NavigationView {
            
            List(selection: $selection) {
                ForEach(reminders, id: \.self) { reminder in
                    VStack(alignment: .leading) {
                        Text(reminder.id.description)
                            .font(.system(size: 22, weight: .medium))
                        Text("The reminder No. \(reminder.id)")
                            .fontWeight(.light)
                    }
                    .frame(height: 60)
                }
            }
            .listStyle(PlainListStyle())
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    deleteButton
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    editButton
                }
            }
            .navigationTitle("Reminders")
            .environment(\.editMode, $editMode)
        }
    }
    
    private func removeItems(_ indexSet: IndexSet) {
        reminders.remove(atOffsets: indexSet)
    }

    private var editButton: some View {
        Button(action: {
            withAnimation {
                editMode = editMode == .active ? .inactive : .active
                selection = Set<Reminder>()
            }
        }) {
            Text(editMode == .inactive ? "Edit" : "Done")
        }
    }

    private var deleteButton: some View {
        Button(action: deleteNumbers) {
            Image(uiImage: editMode == .active ? UIImage(systemName: "trash")! : UIImage.init())
                
        }
    }

    private func deleteNumbers() {
        withAnimation {
            for id in selection {
                if let index = reminders.lastIndex(where: { $0 == id })  {
                    reminders.remove(at: index)
                }
            }
        }
        selection = Set<Reminder>()
    }
}

struct ReminderView_Previews: PreviewProvider {
    static var previews: some View {
        ReminderView()
//            .preferredColorScheme(.dark)
    }
}
