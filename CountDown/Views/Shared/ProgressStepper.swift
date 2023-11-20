//
//  ProgressStepper.swift
//  CountDown
//
//  Created by Ian Docherty on 9/27/23.
//

import SwiftUI

/// Displays a progress indicator of a given length. Each box in the indicator is highlighted a specified color up to the given index. The
/// current index is outlined. The title should only be 5 characters long if the desired result is to have title on a single line.
struct ProgressStepper: View {
    let title: String
    let length: Int
    let currIndex: Int
    let color: Color
    
    var body: some View {
        HStack {
            Text(title)
                .frame(width: 42.0, alignment: .leading)
            
            HStack(spacing: 2) {
                ForEach(0..<length, id: \.self) { index in
                    // Show a rounded rectangle with a fill color and an outline if at current index
                    if index == currIndex {
                        numberText(index: index)
                            .foregroundColor(Color(.systemGray))
                            .overlay {
                                RoundedRectangle(cornerRadius: 3)
                                    .inset(by: 1)
                                    .stroke(color, lineWidth: 2.5)
                            }
                        
                    // Otherwise show a rounded rectangle with a fill color and no outline
                    } else {
                        numberText(index: index)
                            .foregroundColor(.white)
                    }
                }
            }
            .frame(maxWidth: .infinity)
        }
        .padding(.vertical, 1)
    }
    
    /// Returns a Text view containing the given index plus one with a rounded rectangle background
    private func numberText(index: Int) -> some View {
        /* Do not show text if the length above 12. As the length increases, the space available
         to each Text view decreases. When the length is 12 or above, the number text begins to
         get cut off due to the decerased space. Limiting the text to a lenght of 12 prevents this
         issue on all screen sizes tested.
         */
        return Text(length <= 12 ? "\(index + 1)" : "")
            .lineLimit(1)
            .font(.caption)
            .frame(maxWidth: .infinity, maxHeight: 21)
            .background(roundedRectangle(index: index))
    }
    
    /// Returns a rounded rectangle with a fill color that changes depending on the given index
    private func roundedRectangle(index: Int) -> some View {
        if index < currIndex {
            return RoundedRectangle(cornerRadius: 3).fill(color)
        } else {
            return RoundedRectangle(cornerRadius: 3).fill(Color(.systemGray3))
        }
    }
}

struct ProgressStepper_Previews: PreviewProvider {
    static var previews: some View {
        ProgressStepper(title: "Sets", length: 7, currIndex: 3, color: Theme.lightBlue.mainColor)
    }
}
