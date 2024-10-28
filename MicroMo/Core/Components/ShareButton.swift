//
//  ShareButton.swift
//  MicroMo
//
//  Created by Brent Beamer on 5/29/24.
//

import SwiftUI

struct ShareButton: View {
    
    var url: String = "https://www.brentbeamer.com"
    
    
    var body: some View {
        ShareLink(item: URL(string: url)!) {
            
            if let url = URL(string: url) {
                VStack(spacing: 8) {
            
                    Image(systemName: "paperplane")
                        .font(.title)
             
                    Text("Share")
                        .font(.caption)
                        .foregroundStyle(Color.theme.accent)
                        
                }
                .foregroundStyle(Color.theme.accent)
                .padding(8)
                .background(Color.black.opacity(0.001))
            }
        }
    }
}

#Preview {
    
    ShareButton()
    
}
