//
//  TextUtilities.swift
//  CountDown
//
//  Created by Ian Docherty on 10/24/23.
//

import SwiftUI

/// Adds a String Binding extension to limit the length of string to the given max limit
/// Taken from the following source:
/// https://stackoverflow.com/questions/56476007/swiftui-textfield-max-length
extension Binding where Value == String {
    
    /// Limits a String Binding to the given max limit
    /// - Parameter limit: The desired maximum length of the String
    func max(_ limit: Int) -> Self {
        if self.wrappedValue.count > limit {
            DispatchQueue.main.async {
                self.wrappedValue = String(self.wrappedValue.dropLast())
            }
        }
        return self
    }
}
