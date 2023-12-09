//
//  SectionRow.swift
//  CountDown
//
//  Created by Ian Docherty on 12/2/23.
//

import SwiftUI

/// An HStack with a title on the left and text on the right
struct SectionRow: View {
    let title: String
    let text: String
    var color: Color = Color(.systemGray)
    
    var body: some View {
        HStack {
            Text(title)
            Spacer()
            Text(text)
                .foregroundColor(color)
        }
    }
}

struct SectionRow_Previews: PreviewProvider {
    static var previews: some View {
        SectionRow(title: "Name", text: "Repeaters")
    }
}
