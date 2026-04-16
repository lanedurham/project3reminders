//
//  EditSheet.swift
//  project3reminders
//
//  Created by Lane Durham on 4/16/26.
//

import SwiftUI

struct EditSheet: View {
    // TODO: Add title binding
    @Binding var title: String
    @Binding var selectedColor: Color
    
    var body: some View {
        VStack(spacing: 20) {
                // TODO: Add list.bullet.circle.fill icon and TextField
            VStack {
                Image(systemName: "list.bullet.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width:90, height:90)
                    .padding(.top, 25)
                
                TextField("List Name", text: $title)
                    .textFieldStyle(.roundedBorder)
                    .font(.system(size: 24))
                    .padding()
            }
            .background(Color.secondary.opacity(0.15), in: RoundedRectangle(cornerRadius: 16))
            
            ColorChooser(selectedColor: $selectedColor)
            
            Spacer()
        }
        .foregroundStyle(selectedColor)
        .padding()
    }
}

#Preview {
    @Previewable @State var selectedColor: Color = .red
    @Previewable @State var title: String = "Test"
    
    EditSheet(title: $title, selectedColor: $selectedColor)
        .preferredColorScheme(.light)
}
