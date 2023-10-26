//
//  ErrorMessages.swift
//  CountDown
//
//  Created by Ian Docherty on 10/26/23.
//

import SwiftUI

/// An ObservableObject that contains a list of error messages and that returns an error view containing a VStack of these error
/// messages to be displayed in the UI
final class ErrorMessages: ObservableObject {
    @Published var errors: [ErrorText] = []
    
    /// A VStack displaying a list of error messages
    var errorView: some View {
        return VStack(alignment: .leading) {
            ForEach(errors) { errorText in
                errorText
            }
        }
    }
    
    /// Adds a given error text to the array or errors
    /// - Parameter errorText: The error text to add to the list of errors
    func addError(_ errorText: String) {
        errors.append(ErrorText(errorText))
    }
    
    /// Remove all error messages from the list
    func clearErrors() {
        errors = []
    }
}
