//
//  RemindersView.swift
//  Alarmo
//
//  Created by Cédric Bahirwe on 27/07/2021.
//

import SwiftUI

struct RemindersView: View {
    @State private var reminders = Reminder.examples
    @State var editMode = EditMode.inactive
    @State var selection = Set<Reminder>()
    
    @State private var fetchigMore = false
    var paginationLoaderView: some View {
        LoaderView()
            .frame(maxWidth: .infinity)
            .onAppear {
                fetchigMore = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    let count = reminders.count
                    let newReminders = (count...count+10).map{ Reminder(id:$0) }
                    reminders.append(contentsOf: newReminders)
                    fetchigMore = false
                }
            }
    }
    var body: some View {
        NavigationView {
            
            List(selection: $selection) {
                ForEach(reminders, id: \.self) { reminder in
                    ReminderRowView(reminder)
                }
                paginationLoaderView
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

struct RemindersView_Previews: PreviewProvider {
    static var previews: some View {
        RemindersView()
    }
}

extension RemindersView {
    struct ReminderRowView: View {
        let reminder: Reminder
        init(_ reminder: Reminder) {
            self.reminder = reminder
        }
        var body: some View {
            VStack(alignment: .leading) {
                Text(reminder.id.description)
                    .font(.system(size: 22, weight: .medium))
                Text("The reminder No. \(reminder.id)")
                    .fontWeight(.light)
            }
            .frame(height: 60)
        }
    }
    
}
