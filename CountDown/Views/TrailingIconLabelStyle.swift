//
//  TrailingIconLabelStyle.swift
//  CountDown
//
//  Created by Ian Docherty on 9/16/23.
//

import SwiftUI

/// Defines an struct to show the the label to the right of the text as opposed to the default where the label is the the left of the text
/// Taken from the Apple's SwiftUI tutorial
struct TrailingIconLabelStyle: LabelStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.title
            configuration.icon
        }
    }
}

extension LabelStyle where Self == TrailingIconLabelStyle {
    // Because this is static, can use ".trailing" to specify our custom label style
    static var trailingIcon: Self { Self() }
}
