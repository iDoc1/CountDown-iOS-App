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

    var body: some View {
        HStack {
            Text(title)
                .foregroundColor(Color(.systemGray))
            Spacer()
            Text(time)
        }
        .padding(.vertical, 1)
    }
}

struct TimeTextRow_Previews: PreviewProvider {
    static var previews: some View {
        TimeTextRow(title: "Work", time: "0:12")
    }
}
