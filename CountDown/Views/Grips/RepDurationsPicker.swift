//
//  RepDurationsPicker.swift
//  CountDown
//
//  Created by Ian Docherty on 12/19/23.
//

import SwiftUI

/// A pair of number pickers to choose the work and rest durations for a single rep
struct RepDurationsPicker: View {
    @Binding var grip: GripViewModel
    var isInputActive: FocusState<Bool>.Binding
    
    var body: some View {
        Group {
            if grip.hasCustomDurations && grip.repCount <= maxNumberOfReps{
                ForEach(0..<grip.repCount, id: \.self) { index in
                    Section {
                        NumberPicker(
                            number: $grip.customWorkSeconds[index],
                            title: "Work (sec.)",
                            minVal: 1,
                            maxVal: 60,
                            isInputActive: isInputActive)
                        /**
                         Do not include a rest duration on the last rep because it will not be used. A break duration always occurs
                         after the last work duration in a set, so a rest duration is not needed here.
                         */
                        if index < grip.repCount - 1 {
                            NumberPicker(
                                number: $grip.customRestSeconds[index],
                                title: "Rest (sec.)",
                                minVal: 1,
                                maxVal: 60,
                                isInputActive: isInputActive)
                        }
                    } header: {
                        Text("Rep #\(index + 1) Durations")
                    }
                    
                }
            } else {
                NumberPicker(
                    number: $grip.workSeconds,
                    title: "Work (sec.)",
                    minVal: 1,
                    maxVal: 60,
                    isInputActive: isInputActive)
                NumberPicker(
                    number: $grip.restSeconds,
                    title: "Rest (sec.)",
                    minVal: 1,
                    maxVal: 60,
                    isInputActive: isInputActive)
            }
        }
    }
}

struct RepDurationsPicker_Previews: PreviewProvider {
    static let context = PersistenceController.preview.container.viewContext
    static var workout: Workout = {
        let workoutType = WorkoutType(context: context)
        workoutType.name = "powerEndurance"
        
        let workout = Workout(context: context)
        workout.name = "Repeaters"
        workout.descriptionText = "RCTM Advanced Repeaters Protocol"
        workout.createdDate = Date()
        workout.workoutType = workoutType
        return workout
    }()
    
    static var previews: some View {
        List {
            Section {
                RepDurationsPicker(
                    grip: .constant(GripViewModel()),
                    isInputActive: FocusState<Bool>().projectedValue)
            }
        }
    }
}
