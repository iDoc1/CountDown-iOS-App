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
            Text(workout.name ?? "Unknown")
                .font(.headline)
            Spacer()
            HStack {
                Text(workoutTypeString)
                    .font(.subheadline)
                    .foregroundColor(getColorFromWorkoutType(workoutType: workout.workoutType ?? nil))
                Spacer()
                Label(numberOfDaysAgo, systemImage: "calendar.badge.clock")
                    .font(.subheadline)
                    .foregroundColor(Color(.darkGray))
            }
        }
        .padding()
        .foregroundColor(.black)
    }
    
    private var numberOfDaysAgo: String {
        if workout.lastUsedDate != nil {
            let numOfDays = dateDiffInDays(from: workout.lastUsedDate ?? Date())
            return numOfDays == 0 ? "Today" : "\(numOfDays)"
        }
        
        return "Not yet used"
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
        workout.id = UUID()
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
