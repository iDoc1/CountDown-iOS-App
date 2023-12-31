//
//  TimeTextRow.swift
//  CountDown
//
//  Created by Ian Docherty on 10/8/23.
//

import SwiftUI

/// An HStack containing a title aligned to the left and a time aligned to the right
struct TimeTextRow: View {
    let title: String
    let time: String
    var fontTypeOverride: Font? = nil

    var body: some View {
        HStack {
            Text(title)
                .foregroundColor(Color(.systemGray))
                .font(fontType)
            Spacer()
            Text(time)
                .font(fontType)
        }
        .padding(.vertical, 1)
    }
    
    private var fontType: Font? {
        // Check if font type override was given and apply that if so
        if fontTypeOverride != nil {
            return fontTypeOverride
        }
        
        // Otherwise, set font type based on length of time string
        if time.count > 5 {
            return .footnote
        }
        
        return nil
    }
}

struct TimeTextRow_Previews: PreviewProvider {
    static var previews: some View {
        TimeTextRow(title: "Work", time: "0:12")
    }
}
