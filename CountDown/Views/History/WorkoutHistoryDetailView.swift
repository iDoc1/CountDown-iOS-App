//
//  HistoryDetailView.swift
//  CountDown
//
//  Created by Ian Docherty on 12/2/23.
//

import SwiftUI
import CoreData

struct WorkoutHistoryDetailView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var historyViewModel: WorkoutHistoryViewModel
    @ObservedObject var workoutHistory: WorkoutHistory
    
    init(context: NSManagedObjectContext, workoutHist: WorkoutHistory) {
        workoutHistory = workoutHist
        _historyViewModel = State(wrappedValue: WorkoutHistoryViewModel(
            workoutHistory: workoutHist,
            context: context))

    }
    
    var body: some View {
        List {
            Section {
                HStack {
                    Text("Date")
                    Spacer()
                    Text(historyViewModel.workoutDate, style: .date)
                        .foregroundColor(Color(.systemGray))
                    Text(historyViewModel.workoutDate, style: .time)
                        .foregroundColor(Color(.systemGray))
                }
                SectionRow(
                    title: "Length",
                    text: secondsToLongString(seconds: historyViewModel.totalSeconds))
                TextField("Notes", text: $historyViewModel.notes, axis: .vertical)
                    .lineLimit(2...6)
            } header: {
                Text("Workout Details")
            }
            
            Section(header: Text("Grips Used")) {
                ForEach(0..<workoutHistory.gripArray.count, id: \.self) { index in
                    HistoryGripCardView(
                        historyGrip: workoutHistory.gripArray[index],
                        gripIndex: index)
                }
            }
        }
        .navigationTitle("History")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: Button(action: goBack, label: {
            HStack {
                Image(systemName: "chevron.left")
                Text("Back")
            }
        }))

    }
    
    /// Navigates back to the previous screen and saves the current context
    func goBack(){
        historyViewModel.save()
        self.presentationMode.wrappedValue.dismiss()
    }
}

struct HistoryDetailView_Previews: PreviewProvider {
    static let context = PersistenceController.preview.container.viewContext
    static var workoutHistory: WorkoutHistory = {
        let workoutType = WorkoutType(context: context)
        workoutType.name = "powerEndurance"
        
        let workout = Workout(context: context)
        workout.name = "Repeaters"
        workout.descriptionText = "RCTM Advanced Repeaters Protocol"
        workout.createdDate = Date()
        workout.workoutType = workoutType
        
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
        grip.lastBreakMinutes = 2
        grip.lastBreakSeconds = 15
        grip.edgeSize = 18
        grip.sequenceNum = 1
        grip.gripType = gripType
        
        let workoutHistory = WorkoutHistory(context: context)
        workoutHistory.workout = workout
        workoutHistory.totalSeconds = Int16(422)
        workoutHistory.workoutDate = Date()
        
        let historyGrip = HistoryGrip(context: context)
        historyGrip.workoutHistory = workoutHistory
        historyGrip.gripTypeName = grip.gripType?.name
        historyGrip.setCount = grip.setCount
        historyGrip.repCount = grip.repCount
        historyGrip.workSeconds = grip.workSeconds
        historyGrip.restSeconds = grip.restSeconds
        historyGrip.breakMinutes = grip.breakMinutes
        historyGrip.breakSeconds = grip.breakSeconds
        historyGrip.lastBreakMinutes = grip.lastBreakMinutes
        historyGrip.lastBreakSeconds = grip.lastBreakSeconds
        historyGrip.edgeSize = grip.edgeSize
        historyGrip.sequenceNum = grip.sequenceNum

        
        return workoutHistory
    }()
    
    static var previews: some View {
        NavigationStack {
            WorkoutHistoryDetailView(context: context, workoutHist: workoutHistory)
        }
    }
}
