//
//  WorkoutCardView.swift
//  CountDown
//
//  Created by Ian Docherty on 10/21/23.
//

import SwiftUI

struct WorkoutCardView: View {
    @ObservedObject var workout: Workout
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(workout.unwrappedName)
                .font(.headline)
                .accessibilityAddTraits(.isHeader)
            Spacer()
            HStack {
                Text(workoutTypeString)
                    .font(.subheadline)
                    .foregroundColor(getColorFromWorkoutType(workoutType: workout.workoutType ?? nil))
                Spacer()
                Label(numberOfDaysAgo, systemImage: "calendar.badge.clock")
                    .font(.subheadline)
                    .foregroundColor(Color(.darkGray))
                    .accessibilityLabel("Workout last used: \(numberOfDaysAgo)")
            }
        }
        .padding()
    }
    
    private var numberOfDaysAgo: String {
        if workout.lastUsedDate != nil {
            let dateDiffInDays = dateDiffInDays(from: workout.lastUsedDate!)
            return dateDiffString(daysAgo: dateDiffInDays)
        }
        
        return "Not used"
    }
    
    private var workoutTypeString: String {
        let workoutType = WorkoutTypeAsString(rawValue: workout.workoutType?.name ?? "")
        switch workoutType {
        case .none:
            return ""
        case .some(_):
            return workoutType?.displayName ?? ""
        }
    }
}

struct WorkoutCardView_Previews: PreviewProvider {
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
        return workout
    }()
    
    static var previews: some View {
        WorkoutCardView(workout: workout)
            .previewLayout(.fixed(width: 400, height: 60))
    }
}
