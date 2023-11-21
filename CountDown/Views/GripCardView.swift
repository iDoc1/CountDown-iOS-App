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
                        Text("W: \(grip.unwrappedWorkSeconds)s")
                        Text("R: \(grip.unwrappedRestSeconds)s")
                    }
                    Spacer()
                    VStack(alignment: .leading) {
                        Text("Bk: \(timeToString(minutes: grip.unwrappedBreakMinutes, seconds: grip.unwrappedBreakSeconds))")
                        Text("Bk: \(timeToString(minutes: grip.unwrappedLastBreakMinutes, seconds: grip.unwrappedLastBreakSeconds)) (L)")
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
        let gripType2 = GripType(context: context)
        gripType2.name = "Three Finger Drag"
        
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
