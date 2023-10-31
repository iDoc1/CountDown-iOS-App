//
//  ErrorText.swift
//  CountDown
//
//  Created by Ian Docherty on 10/26/23.
//

import SwiftUI

/// Contains red text with the given error message String
struct ErrorText: View, Identifiable {
    let id = UUID()
    
    let errorMessage: String
    
    init(_ errorMessage: String) {
        self.errorMessage = errorMessage
    }
    
    var body: some View {
        Text("- \(errorMessage)")
            .foregroundColor(.red)
    }
}

struct ErrorText_Previews: PreviewProvider {
    static var previews: some View {
        ErrorText("Name field cannot be empty")
            .previewLayout(.fixed(width: 400, height: 60))
    }
}
