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
                                        }
                                    }
                                }
                            }
                        }
                        .onDelete(perform: deleteGripTypes)
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
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
            for index in offsets {
                // Unselect the grip type prior to deleting if it is currently selected
                if gripTypes[index] == selectedGripType {
                    selectedGripType = nil
                }
                moc.delete(gripTypes[index])
            }
            
            try? moc.save()
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
