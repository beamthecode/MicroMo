//
//  StatsView.swift
//  MicroMo
//
//  Created by Brent Beamer on 5/24/24.
//

import SwiftUI

struct StatsView: View {
    
    let title: String
    let value: String
    
   
    
    
    var body: some View {
       
        VStack(alignment: .leading, spacing: 2) {
                Text(title)
                .font(.caption)
                    .foregroundStyle(Color.theme.secondary)
                Text(value)
                    .font(.headline)
                    .foregroundStyle(Color.theme.accent)
            }
           
        
        
    }
}



#Preview {
    StatsView(title: "Title", value: "Value")
}

