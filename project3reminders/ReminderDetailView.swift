//
//  ReminderDetailView.swift
//  project3reminders
//
//  Created by Lane Durham on 4/17/26.
//

import SwiftUI

struct ReminderDetailView: View {
    // TODO: Fill in necessary bindings (Hint: you need 4)
    @Binding var title: String
    @Binding var description: String
    @Binding var date: Date
    @Binding var isCompleted: Bool
    
    @State private var isEditing: Bool = false
   
    var body: some View {
        // TODO: Recreate the view in the write-up video
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                HStack {
                    Spacer()
                    
                    Text(description)
                        .foregroundStyle(.secondary)
                        .padding(.top)
                    
                    Spacer()
                }
                
                Text("Title & Description")
                    .foregroundStyle(.red)
                    .font(.headline)
                
                VStack(spacing: 0) {
                    
                    HStack {
                        Text("Title")
                        Spacer()
                        TextField("Title", text: $title)
                            .multilineTextAlignment(.trailing)
                    }
                    .padding()
                    
                    Divider()
                    
                    HStack {
                        Text("Description")
                        Spacer()
                        TextField("Description", text: $description)
                            .multilineTextAlignment(.trailing)
                    }
                    .padding()
                }
                .background(Color(.systemGray6))
                .clipShape(RoundedRectangle(cornerRadius: 16))
                
                
                // MARK: Date Section
                Text("Date")
                    .foregroundStyle(.red)
                    .font(.headline)
                
                HStack {
                    Text("Date")
                    Spacer()
                    
                    DatePicker(
                        "",
                        selection: $date,
                        displayedComponents: [.date, .hourAndMinute]
                    )
                    .labelsHidden()
                }
                .padding()
                .background(Color(.systemGray6))
                .clipShape(RoundedRectangle(cornerRadius: 16))
                
                
                Spacer()
            }
            .padding()
        }
        // TODO: Add Toolbar for Todo Info
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    isEditing = true
                } label: {
                    Image(systemName: "info.circle")
                }
            }
        }
        
        .sheet(isPresented: $isEditing) {
            EditSheet(title: $title, selectedColor: .constant(.red))
        }
        
        //TODO: Add NavigationTitle
        .navigationTitle(title.isEmpty ? "New Reminder" : title)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    // TODO: Create necessary @State properties to pass into preview (Hint: use @Previewable)
    @Previewable @State var title: String = "PUSH DAY"
    @Previewable @State var description: String = "It's a healthy habit."
    @Previewable @State var date: Date = Date()
    @Previewable @State var isCompleted: Bool = false

    
    NavigationStack {
        ReminderDetailView(
            title: $title,
            description: $description,
            date: $date,
            isCompleted: $isCompleted
        )
    }
}
