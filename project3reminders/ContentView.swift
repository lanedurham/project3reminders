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
                Reminder(title: "Wake up and go to class", description: "", date: Date()),
                Reminder(title: "Actually wake up and go to class", description: "", date: Date()),
                Reminder(title: "Make the day count", description: "", date: Date())
            ],
            color: .yellow
        )
    
    var body: some View {
        NavigationStack {
            List {
                ForEach($page.items) { $reminder in
                    NavigationLink {
                        ReminderDetailView(
                            title: $reminder.title,
                            description: $reminder.description,
                            date: $reminder.date,
                            isCompleted: $reminder.isCompleted
                        )
                    } label: {
                        HStack {
                            Image(systemName: reminder.isCompleted ? "checkmark.circle.fill" : "circle")
                                .foregroundStyle(page.color)
                                .onTapGesture {
                                    reminder.isCompleted.toggle()
                                }
                            
                            VStack(alignment: .leading, spacing: 4) {
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
                                        .font(.headline)
                                }
                                
                                if !reminder.description.isEmpty {
                                    Text(reminder.description)
                                        .font(.subheadline)
                                        .foregroundStyle(.gray)
                                }
                                
                                Text(reminder.date.formatted(
                                    date: .abbreviated,
                                    time: .shortened
                                ))
                                .font(.caption)
                                .foregroundStyle(.gray)
                            }
                        }
                    }
                }
                .onDelete { indexSet in
                    page.items.remove(atOffsets: indexSet)
                }
            }
            .listStyle(.plain)
            
            .navigationTitle(page.title)
            .navigationBarTitleDisplayMode(.large)
            
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        isEditing = true
                    } label: {
                        Image(systemName: "info.circle")
                            .foregroundStyle(page.color)
                    }
                }
            }
            
            .overlay(alignment: .bottomTrailing) {
                Button {
                    let newReminder = Reminder(
                        title: "",
                        description: "",
                        date: Date()
                    )
                    
                    page.items.append(newReminder)
                    newReminderID = newReminder.id
                    
                    // I had to look up how to use this with @FocusState, because I wanted it to immediately focus on the new reminder's title when pressing the + button
                    DispatchQueue.main.async {
                        focusedReminderID = newReminder.id
                    }
                    
                } label: {
                    Image(systemName: "plus.circle.fill")
                        .resizable()
                        .frame(width: 60, height: 60)
                        .foregroundStyle(page.color)
                }
                .padding()
            }
        }
        .sheet(isPresented: $isEditing) {
            EditSheet(title: $page.title, selectedColor: $page.color)
        }
    }
}

#Preview {
    ContentView()
}
