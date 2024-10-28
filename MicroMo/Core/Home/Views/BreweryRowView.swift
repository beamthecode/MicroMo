//
//  BreweryRowView.swift
//  MicroMo
//
//  Created by Brent Beamer on 5/17/24.
//

import SwiftUI

struct BreweryRowView: View {
    
    let brewery: Brewery
    
    
    var body: some View {
        HStack(spacing: 20) {
            
            leftColumn
            
            Spacer()
            
           rightColumn
                
        }
        .font(.subheadline)
        .background(
            Color.theme.background.opacity(0.001)
        )
    }
}


struct BreweryRowView_Previews: PreviewProvider {
    static var previews: some View {
        BreweryRowView(brewery: dev.brewery)
    }
}

/*
#Preview {
    BreweryRowView()
}
*/

extension BreweryRowView {
    private var leftColumn: some View {
        HStack(spacing: 20) {
            Image("Logo")
                .resizable()
                .clipShape(Circle())
            .frame(width: 30, height: 30)
            .padding(.leading)
            .foregroundStyle(Color.theme.accent)
                
            
            Text(brewery.name)
                .font(.headline)
                .foregroundStyle(.accent)
        }
    }
    
    private var rightColumn: some View {
            VStack(alignment: .trailing) {
                Text(brewery.city)
                    .bold()
                    .foregroundStyle(Color.theme.accent)
                
//                Text(brewery.stateProvince)
//                    .bold()
//                    .foregroundStyle(Color.theme.accent)
                
            }
            .frame(width: UIScreen.main.bounds.width / 3.5, alignment: .leading)
        
    }
}
