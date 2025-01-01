//
//  LeftRightSection.swift
//  CountDown
//
//  Created by Ian Docherty on 12/14/24.
//

import SwiftUI
import CoreData


struct LeftRightSection: View {
    @State private var workout: WorkoutViewModel
    var isInputActive: FocusState<Bool>.Binding
    
    init(context: NSManagedObjectContext, workout: Workout, isInputActive: FocusState<Bool>.Binding) {
        _workout = State(wrappedValue: WorkoutViewModel(workout: workout, context: context))
        self.isInputActive = isInputActive
    }
    
    var body: some View {
        Section {
            Toggle(isOn: $workout.isLeftRightEnabled.animation()) {
                Text("Left/Right Mode")
            }
            
            if workout.isLeftRightEnabled {
                HStack(spacing: 20) {
                    Text("Start hand")
                    Picker("Start hand", selection: $workout.startHand) {
                        Text(Hand.left.rawValue).tag(Hand.left.rawValue)
                        Text(Hand.right.rawValue).tag(Hand.right.rawValue)
                    }
                    .pickerStyle(.segmented)
                }
                
                HStack {
                    NumberPicker(
                        number: $workout.secondsBetweenHands,
                        title: "Rest between hands (sec.)",
                        minVal: 1,
                        maxVal: 60,
                        isInputActive: isInputActive)
                }
            }
        } header: {
            Text("Grip Mode")
        } footer: {
            Text("Enables separate left/right hand per rep")
        }
        .onChange(of: workout) { newValue in            
            // Save the workout any the left/right mode values are changed
            workout.save()
        }
    }
}

struct LeftRightSection_Previews: PreviewProvider {
    static let persistence = PersistenceController.preview
    static var workout: Workout = {
        let context = persistence.container.viewContext
        
        let workoutType = WorkoutType(context: context)
        workoutType.name = "powerEndurance"
        
        let workout = Workout(context: context)
        workout.name = "Repeaters"
        workout.descriptionText = "RCTM Advanced Repeaters Protocol"
        workout.createdDate = Date()
        workout.workoutType = workoutType
        workout.isLeftRightEnabled = true
        
        let gripType = GripType(context: context)
        gripType.name = "Half Crimp"
        
        let grip = Grip(context: context)
        grip.workout = workout
        grip.setCount = 3
        grip.repCount = 6
        grip.workSeconds = 7
        grip.restSeconds = 3
        grip.breakMinutes = 1
        grip.breakSeconds = 30
        grip.edgeSize = 18
        grip.sequenceNum = 1
        grip.gripType = gripType
        
        return workout
    }()
    
    static var previews: some View {
        List {
            LeftRightSection(
                context: persistence.container.viewContext,
                workout: workout,
                isInputActive: FocusState<Bool>().projectedValue)
        }
    }
}
