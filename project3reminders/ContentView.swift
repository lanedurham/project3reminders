//
//  ContentView.swift
//  project3reminders
//
//  Created by Lane Durham on 4/16/26.
//

import SwiftUI

struct ContentView: View {
    @FocusState private var focusedReminderID: UUID?
    @State private var newReminderID: UUID?
    @State private var isEditing: Bool = false
    // TODO: Add an @State property to hold a RemindersPage struct
    @State private var page: RemindersPage = RemindersPage(
            title: "Reminders",
            items: [
                Reminder(title: "Wake up and go to class"),
                Reminder(title: "Actually wake up and go to class"),
                Reminder(title: "Make the day count")
            ],
            color: .yellow
        )
    
    var body: some View {
        VStack {
            // TODO: Add header view
            HStack {
                Text(page.title)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundStyle(page.color)
                
                Spacer()
                
                Button {
                    isEditing = true
                } label: {
                    Image(systemName: "info.circle")
                        .imageScale(.large)
                        .foregroundStyle(page.color)
                }
            }
            .padding()
            
            List {
                // TODO: Loop through the page's reminders using ForEach
                ForEach($page.items) { $reminder in
                    HStack {
                        Image(systemName: reminder.isCompleted ? "checkmark.circle.fill" : "circle")
                            .foregroundStyle(page.color)
                            .onTapGesture {
                                reminder.isCompleted.toggle()
                            }
                        
                        if reminder.id == newReminderID {
                            TextField("New Reminder", text: $reminder.title)
                                .focused($focusedReminderID, equals: reminder.id)
                                .onSubmit {
                                    newReminderID = nil
                                    focusedReminderID = nil
                                }
                        } else {
                            Text(reminder.title)
                                .strikethrough(reminder.isCompleted)
                        }
                    }
                }
                .onDelete { indexSet in
                    page.items.remove(atOffsets: indexSet)
                }
            }
            .listStyle(.plain)
            
            // TODO: Add footer view
            HStack {
                Spacer()
                
                Button {
                    // I had to look up how to use this with @FocusState, because I wanted it to immediately focus on the new reminder's title when pressing the + button
                    
                    let newReminder = Reminder(title: "")
                    page.items.append(newReminder)
                    newReminderID = newReminder.id
                    
                    DispatchQueue.main.async {
                        focusedReminderID = newReminder.id
                    }
                } label: {
                    Image(systemName: "plus.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 70, height: 70)
                        .foregroundStyle(page.color)
                }
            }
            .padding(40)

        }
        .sheet(isPresented: $isEditing) {
            // TODO: Add remaining binding
            EditSheet(title: $page.title, selectedColor: $page.color)
        }
    }
}

#Preview {
    ContentView()
}
