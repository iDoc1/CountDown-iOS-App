//
//  InfoButtonWithPopover.swift
//  CountDown
//
//  Created by Ian Docherty on 12/20/23.
//

import SwiftUI
import Popovers

/// A button with an info icon that shows the given text when tapped
struct InfoButtonWithPopover: View {
    @State private var isShowingDecrementPopover = false
    var text: String
    
    var body: some View {
        Button {
            isShowingDecrementPopover = true
        } label: {
            Image(systemName: "info.circle.fill")
                .foregroundColor(.blue)
        }
        .buttonStyle(.plain)
        .popover(
            present: $isShowingDecrementPopover,
            attributes: {
                $0.sourceFrameInset.bottom = -12
                $0.position = .absolute(
                    originAnchor: .bottom,
                    popoverAnchor: .top
                )
            }
        ) {
            Templates.Container(
                arrowSide: .top(.centered),
                backgroundColor: .blue
            ) {
                Text(text)
                .foregroundColor(.white)
            }
            .frame(maxWidth: 300)
        }
    }
}

struct InfoButtonWithPopover_Previews: PreviewProvider {
    static var previews: some View {
        InfoButtonWithPopover(text: "Informational text here")
    }
}
