//
//  Color.swift
//  MicroMo
//
//  Created by Brent Beamer on 5/16/24.
//

import Foundation
import SwiftUI

extension Color {
    
    static let theme = ColorTheme()
    static let launch = LaunchTheme()
}


struct ColorTheme {
    
    let accent = Color("AccentColor")
    let background = Color("BackgroundColor")
    let secondary = Color("SecondaryText")
}

struct LaunchTheme {
    let launchBackground = Color("LaunchBackgroundColor")
    let launchAccent = Color("LaunchAccentColor")
}
