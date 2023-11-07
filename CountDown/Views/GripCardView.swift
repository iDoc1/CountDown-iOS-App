//
//  GripCardView.swift
//  CountDown
//
//  Created by Ian Docherty on 11/6/23.
//

import SwiftUI

struct GripCardView: View {
    var grip: Grip

    var body: some View {
        HStack {
            Text("\(grip.unwrappedSequenceNum)")
                .font(.title)
                .padding()
            Spacer()
                .frame(width: 20)
            VStack {
                Text(grip.unwrappedGripTypeName)
                    .font(.headline)
                HStack {
                    Text("S: 1 | R: 1 | W: 7s | R: 3s | B: 1:30")
                        .font(.subheadline)
                }
            }
            Spacer()
        }
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
        grip1.breakSeconds = 30
        grip1.edgeSize = 18
        grip1.sequenceNum = 1
        grip1.gripType = gripType1
        
        return grip1
    }()
    static var previews: some View {
        GripCardView(grip: grip)
            .previewLayout(.fixed(width: 400, height: 60))
    }
}
