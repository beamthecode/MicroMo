//
//  HomeView.swift
//  MicroMo
//
//  Created by Brent Beamer on 5/16/24.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject private var viewModel: HomeViewModel
    @State private var showMyBreweries: Bool = false // animate right
    @State private var showBreweriesView: Bool = false // new sheet
    @State private var showSettingsView: Bool = false // new sheet
    @State private var selectedBrewery: Brewery? = nil
    @State private var showDetailView: Bool = false
    
    var body: some View {
        ZStack {
            // background layer
            Color.theme.background
                .ignoresSafeArea()
                .sheet(isPresented: $showBreweriesView, content: {
                    MyBreweriesView()
                        .environmentObject(viewModel)
                })
            
            // content layer
            VStack {
                homeHeader
                
                SearchBarView(searchText: $viewModel.searchText)
                
                columnTitles
                
                if !showMyBreweries {
                    allBreweriesList
                        .transition(.move(edge: .leading))
                }
                if showMyBreweries {
                    ZStack(alignment: .top) {
                        if viewModel.myBreweries.isEmpty && viewModel.searchText.isEmpty {
                           myBreweryEmptyText
                        } else {
                            myBreweriesList
                        }
                    }
                    .transition(.move(edge: .trailing))
                }
                
                Spacer(minLength: 0)
            }
            .sheet(isPresented: $showSettingsView, content: {
                SettingsView()
            })
        }
        .background(
            NavigationLink(
                destination: DetailLoadingView(brewery: $selectedBrewery),
                isActive: $showDetailView,
                label: { EmptyView() })
        )
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            HomeView()
                .navigationBarHidden(true)
        }
        .environmentObject(dev.homeVM)
    }
}

/*
#Preview {
    NavigationStack {
        HomeView()
    }
}
*/

extension HomeView {
    
    private var homeHeader: some View {
        HStack {
            CircleButtonView(iconName: showMyBreweries ? "plus" : "info")
                .animation(.none)
                .onTapGesture {
                    if showMyBreweries {
                        showBreweriesView.toggle()
                    } else {
                        showSettingsView.toggle()
                    }
                }
                .background(
                    CircleButtonAnimationView(animate: $showMyBreweries)
                )
            Spacer()
            Text(showMyBreweries ? "My Breweries" : "Missouri Microbreweries")
                .font(.headline)
                .fontWeight(.heavy)
                .foregroundStyle(Color.theme.accent)
                .animation(.none)
            Spacer()
            CircleButtonView(iconName: "chevron.right")
                .rotationEffect(Angle(degrees: showMyBreweries ? 180 : 0))
                .onTapGesture {
                    withAnimation(.spring()) {
                        showMyBreweries.toggle()
                    }
                }
        }
        .padding(.horizontal)
    }
    
    private var allBreweriesList: some View {
        List {
            ForEach(viewModel.allBreweries) { brewery in
                BreweryRowView(brewery: brewery)
                    .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 0))
                    .onTapGesture {
                        segue(brewery: brewery)
                    }
                    .listRowBackground(Color.theme.background)
            }
        }
        .listStyle(PlainListStyle())
        
    }
    
    private var myBreweriesList: some View {
        List {
            ForEach(viewModel.myBreweries) { brewery in
                BreweryRowView(brewery: brewery)
                    .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 0))
                    .onTapGesture {
                        segue(brewery: brewery)
                    }
                    .listRowBackground(Color.theme.background)
            }
        }
        .listStyle(PlainListStyle())
        
    }
    
    private var myBreweryEmptyText: some View {
        Text("You haven't added any breweries yet. Click the plus button to add your favorite breweries. Cheers! 🍻")
            .font(.callout)
            .foregroundStyle(Color.theme.accent)
            .fontWeight(.medium)
            .multilineTextAlignment(.center)
            .padding(50)
    }
    
    private func segue(brewery: Brewery) {
        selectedBrewery = brewery
        showDetailView.toggle()
    }
    
    private var columnTitles: some View {
        HStack {
            HStack(spacing: 4) {
                Text("Brewery")
                Image(systemName: "arrow.triangle.swap")
                    .opacity(viewModel.sortOption == .brewery || viewModel.sortOption == .breweryReversed ? 1.0 : 0.0)
                    .rotationEffect(Angle(degrees: viewModel.sortOption == .brewery ? 0 : 180))
            }
            .onTapGesture {
                withAnimation(.default) {
                    viewModel.sortOption = viewModel.sortOption == .brewery ? .breweryReversed : .brewery
                }
            }
            
            Spacer()
            HStack(spacing: 4) {
                Text("Location")
                Image(systemName: "arrow.triangle.swap")
                    .opacity(viewModel.sortOption == .location || viewModel.sortOption == .locationReversed ? 1.0 : 0.0)
                    .rotationEffect(Angle(degrees: viewModel.sortOption == .location ? 0 : 180))
                    
            }
            .frame(width: UIScreen.main.bounds.width / 3.5)
            .onTapGesture {
                withAnimation(.default) {
                    viewModel.sortOption = viewModel.sortOption == .location ? .locationReversed : .location
                }
            }
            
        }
        .font(.caption)
        .foregroundStyle(Color.theme.secondary)
        .padding(.leading)
        .padding(.top)
    }
}
