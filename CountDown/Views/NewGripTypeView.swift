//
//  NewGripTypeView.swift
//  CountDown
//
//  Created by Ian Docherty on 11/4/23.
//

import SwiftUI

/// A view to add a new grip type
struct NewGripTypeView: View {
    @Environment(\.managedObjectContext) private var moc
    @State private var newGripTypeName = ""
    
    var body: some View {
        HStack {
            TextField("New Grip Type", text: $newGripTypeName.max(40))
            Button(action: {
                withAnimation {
                    let newGripType = GripType(context: moc)
                    newGripType.name = newGripTypeName
                    
                    try? moc.save()
                    newGripTypeName = ""
                }
            }) {
                Image(systemName: "plus.circle.fill")
                    .accessibilityLabel("Add Grip Type")
            }
            .disabled(newGripTypeName.isEmpty)
        }
    }
}

struct NewGripTypeView_Previews: PreviewProvider {
    static var previews: some View {
        NewGripTypeView()
            .previewLayout(.fixed(width: 400, height: 60))
    }
}
