//
//  WorkoutsView.swift
//  CountDown
//
//  Created by Ian Docherty on 9/9/23.
//

import SwiftUI

struct WorkoutsView: View {
    @FetchRequest(sortDescriptors: [
        SortDescriptor(\.name),
        SortDescriptor(\.lastUsedDate)
    ]) var workouts: FetchedResults<Workout>
    
    var body: some View {
        NavigationStack {
            List(workouts) { workout in
                NavigationLink(destination: WorkoutDetailView()) {
                    WorkoutCardView(workout: workout)
                }
            }
            .navigationTitle("Workouts")
        }
    }
}

struct WorkoutsView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutsView()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
