//
//  NewGripTypeView.swift
//  CountDown
//
//  Created by Ian Docherty on 11/4/23.
//

import SwiftUI

/// A view to add a new grip type. Accepts a ScrollViewProxy to enable this view to scroll to the bottom to show suggested grip types.
struct NewGripTypeView: View {
    @Environment(\.managedObjectContext) private var moc
    @State private var newGripTypeName = ""
    @State private var suggestedGripTypes: [String] = []
    let proxy: ScrollViewProxy
    
    var body: some View {
        Group {
            Section {
                HStack {
                    TextField("New Grip Type", text: $newGripTypeName.max(40))
                        .id("textfield")
                    Button(action: {
                        withAnimation {
                            let newGripType = GripType(context: moc)
                            newGripType.name = newGripTypeName
                            
                            do {
                                try moc.save()
                            } catch {
                                print("Failed to save Grip Type: \(error)")
                            }
                            newGripTypeName = ""
                        }
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .accessibilityLabel("Add Grip Type")
                    }
                    .disabled(newGripTypeName.isEmpty)
                }
            } footer: {
                Text("Add a new grip type to the list. Some examples are 'Half Crimp' " +
                     "or 'Three Finger Drag'.")
            }
            
            // Only show suggestions if grip type form is populated and at least one suggestions exists
            if newGripTypeName.trimmingCharacters(in: .whitespaces).count > 0 &&
                suggestedGripTypes.count > 0
            {
                Section {
                    ForEach(suggestedGripTypes, id: \.self) { gripTypeName in
                        Button(gripTypeName) {
                            newGripTypeName = gripTypeName
                        }
                        .id(gripTypeName)
                    }
                } header: {
                    Text("Suggested Grip Types")
                }
            }
        }
        .onChange(of: newGripTypeName) { newValue in
            withAnimation {
                suggestedGripTypes = getSuggestedGripTypes(newGripTypeName: newValue)
            }
        }
        // Scroll to bottom of suggestions list any time it changes
        .onChange(of: suggestedGripTypes) { newValue in
            proxy.scrollTo(suggestedGripTypes.last, anchor: .bottom)
        }
    }
}

struct NewGripTypeView_Previews: PreviewProvider {
    static var previews: some View {
        ScrollViewReader { proxy in
            List {
                NewGripTypeView(proxy: proxy)
                    .previewLayout(.fixed(width: 400, height: 60))
            }
        }
    }
}
