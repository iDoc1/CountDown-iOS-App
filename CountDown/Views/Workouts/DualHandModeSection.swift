//
//  LeftRightSection.swift
//  CountDown
//
//  Created by Ian Docherty on 12/14/24.
//

import SwiftUI
import CoreData


/// Shared Dual Hand Mode settings section. Works with any source of state through bindings, so it can be used by both the
/// workout detail screen and the Timer Setup screen.
struct DualHandModeSection: View {
    @Binding var isLeftRightEnabled: Bool
    @Binding var startHand: String
    @Binding var secondsBetweenHands: Int
    @Binding var handSwitchMode: String
    var isInputActive: FocusState<Bool>.Binding
    
    var body: some View {
        Section {
            Toggle(isOn: $isLeftRightEnabled.animation()) {
                Text("Dual Hand Mode")
            }
            
            if isLeftRightEnabled {
                HStack(spacing: 20) {
                    Text("Start hand")
                    Picker("Start hand", selection: $startHand) {
                        Text(Hand.left.rawValue).tag(Hand.left.rawValue)
                        Text(Hand.right.rawValue).tag(Hand.right.rawValue)
                    }
                    .pickerStyle(.segmented)
                }
                
                HStack {
                    NumberPicker(
                        number: $secondsBetweenHands,
                        title: "Rest between hands (sec.)",
                        minVal: 1,
                        maxVal: 60,
                        isInputActive: isInputActive)
                }
                
                HStack(spacing: 20) {
                    Text("Switch hands every")
                    Picker("Switch hands every", selection: $handSwitchMode) {
                        Text(HandSwitchMode.set.rawValue).tag(HandSwitchMode.set.rawValue)
                        Text(HandSwitchMode.rep.rawValue).tag(HandSwitchMode.rep.rawValue)
                    }
                    .pickerStyle(.segmented)
                }
            }
        } header: {
            Text("Grip Mode")
        } footer: {
            Text("Enables separate left/right hand per \(handSwitchMode.lowercased())")
        }
    }
}

/// Dual Hand Mode section for a saved workout. Saves the workout whenever a setting changes.
struct WorkoutDualHandModeSection: View {
    @State private var workout: WorkoutViewModel
    var isInputActive: FocusState<Bool>.Binding
    
    init(context: NSManagedObjectContext, workout: Workout, isInputActive: FocusState<Bool>.Binding) {
        _workout = State(wrappedValue: WorkoutViewModel(workout: workout, context: context))
        self.isInputActive = isInputActive
    }
    
    var body: some View {
        DualHandModeSection(
            isLeftRightEnabled: $workout.isLeftRightEnabled,
            startHand: $workout.startHand,
            secondsBetweenHands: $workout.secondsBetweenHands,
            handSwitchMode: $workout.handSwitchMode,
            isInputActive: isInputActive)
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
            WorkoutDualHandModeSection(
                context: persistence.container.viewContext,
                workout: workout,
                isInputActive: FocusState<Bool>().projectedValue)
        }
    }
}
