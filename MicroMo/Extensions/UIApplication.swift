//
//  UIApplication.swift
//  MicroMo
//
//  Created by Brent Beamer on 5/21/24.
//

import Foundation
import SwiftUI

extension UIApplication {
    
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    
}
