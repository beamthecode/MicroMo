//
//  MyBreweriesView.swift
//  MicroMo
//
//  Created by Brent Beamer on 5/22/24.
//

import SwiftUI

struct MyBreweriesView: View {
    
    @EnvironmentObject private var viewModel: HomeViewModel
    @State private var selectedBrewery: Brewery? = nil
    @State private var showCheckmark: Bool = false
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    SearchBarView(searchText: $viewModel.searchText)
                        .padding()
                    breweryLogoList
                }
            }
            .background(Color.theme.background.ignoresSafeArea())
            .navigationTitle("Edit My Breweries")
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarLeading) {
                    XMarkButton()
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                   trailingNavBarButtons
                }
            })
            .onChange(of: viewModel.searchText, perform: { value in
                if value == "" {
                    removeSelectedBrewery()
                }
            })
        }
    }
}


struct MyBreweriesView_Previews: PreviewProvider {
    static var previews: some View {
        MyBreweriesView()
            .environmentObject(dev.homeVM)
    }
}


/*
#Preview {
    MyBreweriesView()
        
}
*/

extension MyBreweriesView {
    private var breweryLogoList: some View {
        ScrollView(.vertical, showsIndicators: false, content: {
            LazyVStack(spacing: 10) {
                ForEach(viewModel.searchText.isEmpty ? viewModel.myBreweries : viewModel.allBreweries) { brewery in
                    BreweryRowView(brewery: brewery)
                        .padding(4)
                        .onTapGesture {
                            withAnimation(.easeIn) {
                                selectedBrewery = brewery
                            }
                        }
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(selectedBrewery?.id == brewery.id ? Color.theme.accent : Color.clear, lineWidth: 1)
                        )
                }
            }
            .padding(.horizontal, 4)
            .padding(.top)
            
        })
    }
    
 
    
    private var trailingNavBarButtons: some View {
        HStack(spacing: 10) {
            Image(systemName: "checkmark")
                .opacity(showCheckmark ? 1.0 : 0.0)
            Button(action: {
                saveButtonPressed()
            }, label: {
                Text("Save".uppercased())
            })
            .opacity(
                selectedBrewery != nil ? 1.0 : 0.0
            )
            
        }
        .font(.headline)
    }
    
    private func saveButtonPressed() {
        guard let brewery = selectedBrewery else { return }
        
        // save to portfolio
        viewModel.updateMyBreweries(brewery: brewery)
        // show checkmark
        withAnimation(.easeIn) {
            showCheckmark = true
            removeSelectedBrewery()
        }
        
        // hide keyboard
        UIApplication.shared.endEditing()
        
        // hide checkmark
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            showCheckmark = false
        }
    }
    
    private func removeSelectedBrewery() {
        selectedBrewery = nil
        viewModel.searchText = ""
    }
}
