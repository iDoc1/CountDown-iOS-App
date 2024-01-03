//
//  GripCardView.swift
//  CountDown
//
//  Created by Ian Docherty on 11/6/23.
//

import SwiftUI

/// A card view that displays information about a specific grip. When tapped, allows user to edit the grip information on a different sheet.
struct GripCardView: View {
    @Environment(\.managedObjectContext) var moc
    @ObservedObject var grip: Grip
    @State private var isShowingEditGripSheet = false
    var titleColor: Color
    var gripIndex: Int

    var body: some View {
        HStack {
            Text("\(gripIndex + 1)")
                .font(.title)
            Spacer(minLength: 15)
            VStack(alignment: .leading) {
                Text(grip.gripType?.unwrappedName ?? "Grip Type Deleted")
                    .font(.headline)
                    .foregroundColor(titleColor)
                HStack {
                    VStack(alignment: .leading) {
                        Text("Sets: \(grip.unwrappedSetCount)")
                        Text("Reps: \(grip.unwrappedRepCount)")
                    }
                    Spacer()
                    VStack(alignment: .leading) {
                        Text("Work: \(workSecondsString)")
                        Text("Rest: \(restSecondsString)")
                    }
                    Spacer()
                    VStack(alignment: .leading) {
                        Text("Break: \(timeToString(minutes: grip.unwrappedBreakMinutes, seconds: grip.unwrappedBreakSeconds))")
                        Text("Break: \(timeToString(minutes: grip.unwrappedLastBreakMinutes, seconds: grip.unwrappedLastBreakSeconds)) (L)")
                    }
                    Spacer()
                }
                .font(.caption)
                .foregroundColor(Color(.systemGray))
            }
            Spacer()
        }
        .contentShape(Rectangle()) // Tappable area set as a rectangle
        .onTapGesture {
            isShowingEditGripSheet = true
        }
        .sheet(isPresented: $isShowingEditGripSheet, content: {
            GripEditView(context: moc, grip: grip, isShowingEditGripSheet: $isShowingEditGripSheet)
        })
    }
    
    /// Shows the work seconds or a message if grip has custom durations
    private var workSecondsString: String {
        if grip.hasCustomDurations {
            return customDurationsString(
                customSeconds: grip.unwrappedCustomWork,
                range: grip.unwrappedRepCount)
        }
        return "\(grip.unwrappedWorkSeconds)s"
    }
    
    /// Shows the rest seconds or a message if grip has custom durations
    private var restSecondsString: String {
        if grip.hasCustomDurations {
            return customDurationsString(
                customSeconds: grip.unwrappedCustomRest,
                range: grip.unwrappedRepCount - 1)
        }
        return "\(grip.unwrappedRestSeconds)s"
    }
}

struct GripCardView_Previews: PreviewProvider {
    static let context = PersistenceController.preview.container.viewContext
    static var grip: Grip = {
        let workoutType = WorkoutType(context: context)
        workoutType.name = "powerEndurance"
        
        let workout = Workout(context: context)
        workout.name = "Repeaters"
        workout.descriptionText = "RCTM Advanced Repeaters Protocol"
        workout.createdDate = Date()
        workout.workoutType = workoutType
        
        let gripType1 = GripType(context: context)
        gripType1.name = "Half Crimp"
        
        let grip1 = Grip(context: context)
        grip1.workout = workout
        grip1.setCount = 3
        grip1.repCount = 6
        grip1.workSeconds = 7
        grip1.restSeconds = 3
        grip1.breakMinutes = 1
        grip1.breakSeconds = 0
        grip1.lastBreakMinutes = 59
        grip1.lastBreakSeconds = 59
        grip1.decrementSets = false
        grip1.hasCustomDurations = false
        grip1.edgeSize = 18
        grip1.sequenceNum = 1
        grip1.gripType = gripType1
        
        return grip1
    }()

    static var previews: some View {
        GripCardView(grip: grip, titleColor: Theme.lightBlue.mainColor, gripIndex: 0)
            .padding()
            .previewLayout(.fixed(width: 275, height: 60))
    }
}
