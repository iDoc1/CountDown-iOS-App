//
//  GripTypePickerView.swift
//  CountDown
//
//  Created by Ian Docherty on 11/4/23.
//

import SwiftUI
import CoreData

/// A picker view for creating and choosing new grip types to add to a grip
struct GripTypePickerView: View {
    @Environment(\.managedObjectContext) private var moc
    @Environment(\.colorScheme) private var colorScheme
    @Binding var selectedGripType: GripType?
    @FetchRequest(sortDescriptors: [
        SortDescriptor(\.name),
    ]) private var gripTypes: FetchedResults<GripType>
    
    var body: some View {
        Group {
            if gripTypes.count == 0 {
                List {
                    NewGripTypeView()
                }
            } else {
                List {
                    Section {
                        ForEach(0..<gripTypes.count, id: \.self) { index in
                            HStack {
                                Button(action: {
                                    selectedGripType = gripTypes[index]
                                }) {
                                    HStack {
                                        Text(gripTypes[index].unwrappedName)
                                            .foregroundColor(colorScheme == .dark ? .white : .black)
                                        Spacer()
                                        
                                        if selectedGripType == gripTypes[index] {
                                            Image(systemName: "checkmark")
                                                .foregroundColor(.blue)
                                                .accessibilityIdentifier("selectedGripType")
                                        }
                                    }
                                }
                            }
                        }
                        .onDelete(perform: deleteGripTypes)
                    } footer: {
                        Text("Deleting a grip type currently in use by a grip will cause the grip" +
                             " type to show up as 'Grip Type Deleted'")
                    }
                    NewGripTypeView()
                }
            }
        }
        .navigationTitle("Grip Types")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    /// Deletes the grip types at the given index values
    private func deleteGripTypes(at offsets: IndexSet) {
        /*
         Add slight delay to prevent SwiftUI deletion bug. Bug not fixed as of 11/6/23.
         Taken from following source:
         https://stackoverflow.com/questions/60358948/swiftui-delete-row-in-list-with-context-menu-ui-glitch
         */
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
            for index in offsets {
                // Unselect the grip type prior to deleting if it is currently selected
                if gripTypes[index] == selectedGripType {
                    selectedGripType = nil
                }
                moc.delete(gripTypes[index])
            }
            
            do {
                try moc.save()
            } catch {
                print("Failed to save Grip Type: \(error)")
            }
        }
    }
}

struct GripTypePickerView_Previews: PreviewProvider {
    static let context = PersistenceController.preview.container.viewContext
    static var gripType: GripType = {
        let gripType = GripType(context: context)
        gripType.name = "IM 2-Pad Pocket"
        return gripType
    }()

    static var previews: some View {
        NavigationStack {
            GripTypePickerView(selectedGripType: .constant(gripType))
        }
        .environment(\.managedObjectContext, context)
    }
}
