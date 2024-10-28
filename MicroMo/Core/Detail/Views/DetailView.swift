//
//  DetailView.swift
//  MicroMo
//
//  Created by Brent Beamer on 5/23/24.
//

import SwiftUI

struct DetailLoadingView: View {
    
    @Binding var brewery: Brewery?
    
    var body: some View {
        
        ZStack {
            if let brewery = brewery {
                DetailView(brewery: brewery)
            }
        }
    }
}

struct DetailView: View {
    
    @StateObject private var viewModel: DetailViewModel
    private let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    private let spacing: CGFloat = 30
    
    
    init(brewery: Brewery) {
        
        _viewModel = StateObject(wrappedValue: DetailViewModel(brewery: brewery))
        
    }
    
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Image("Logo")
                    .resizable()
                    .scaledToFit()

                    
                Text("Overview")
                    .font(.title)
                    .bold()
                    .foregroundStyle(Color.theme.accent)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Divider()
                
            OverviewGrid
                
            
                
                Text("Additional Resources")
                    .font(.title)
                    .bold()
                    .foregroundStyle(Color.theme.accent)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Divider()
                
                ZStack {
                    if let websiteString = viewModel.websiteURL,
                       let url = URL(string: websiteString) {
                        HStack(spacing: 20) {
                            Link("\(viewModel.brewery.name) Website", destination: url)
                            
                            Spacer()
                            
                            ShareButton(url: websiteString)
                                .frame(width: 50, height: 50)
                        }
                    }
                }
                .accentColor(Color.theme.accent)
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.title3)
            }
            .padding()
        }
        .background(Color.theme.background)
        .navigationTitle(viewModel.brewery.name)
        
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            DetailView(brewery: dev.brewery)
        }
    }
}

/*
#Preview {
    DetailView()
}
*/


extension DetailView {
    
    
    private var OverviewGrid: some View {
        LazyVGrid(
            columns: columns,
            alignment: .leading,
            spacing: spacing,
            pinnedViews: [],
            content: {
                StatsView(title: "Brewery Type", value: viewModel.brewery.breweryType)
                StatsView(title: "Address", value: viewModel.brewery.address1)
                StatsView(title: "City", value: viewModel.brewery.city)
                StatsView(title: "State", value: viewModel.brewery.stateProvince)
                StatsView(title: "Zip Code", value: viewModel.brewery.postalCode)
                StatsView(title: "Phone", value: viewModel.brewery.phone ?? "N/A")
                
        })
    }
}



/*
 ForEach(0..<6) { _ in
     StatsView(title: "Title", value: "Value")
 }
 */
