//
//  SettingsView.swift
//  MicroMo
//
//  Created by Brent Beamer on 5/25/24.
//

import SwiftUI

struct SettingsView: View {
    
    let defaultURL = URL(string: "https://www.google.com")!
    let openBreweryURL = URL(string: "https://www.openbrewerydb.org")!
    let missouriGuildURL = URL(string: "https://www.mocraftbeer.com")!
    let gitHubURL = URL(string: "https://github.com/beamthecode")!
    let portfolioURL = URL(string: "https://www.brentbeamer.com/iosdeveloper-portfolio")!
    let projectURL = URL(string: "https://github.com/beamthecode?tab=repositories")!
   
    
    var body: some View {
        NavigationStack {
            ZStack {
                // background
                Color.theme.background.ignoresSafeArea()
                
               // content layer
                List {
                    appSection
                        .listRowBackground(Color.theme.background.opacity(0.50))
                    
                    brentSection
                        .listRowBackground(Color.theme.background.opacity(0.50))
                    
                    openBreweryDBSection
                        .listRowBackground(Color.theme.background.opacity(0.50))
                    
                    
                    missouriGuildSection
                        .listRowBackground(Color.theme.background.opacity(0.50))
                    
                    applicationSection
                        .listRowBackground(Color.theme.background.opacity(0.50))
                }
            }
            .font(.headline)
            .accentColor(.blue)
            .listStyle(GroupedListStyle())
            .navigationTitle("Settings")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    XMarkButton()
                }
            }
        }
    }
}

#Preview {
    SettingsView()
}


extension SettingsView {
    
    private var appSection: some View {
        Section(header: Text("MicroMo")) {
            VStack(alignment: .leading) {
                Image("Logo")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Text("This app showcases a working knowledge of Combine, API’s, CoreData, & App Storage. The app architecture is MVVM. The app utilizes an API to pull information on Missouri Microbreweries from the Open Brewery DB database. Users can add their favorite breweries to a list. This information is stored in CoreData & App Storage, which allows for persistence between restarts of the app. ")
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundStyle(Color.theme.accent)
            }
            .padding(.vertical)
            Link("Visit this project on GitHub →", destination: projectURL)
            
        }
    }
    private var brentSection: some View {
        Section(header: Text("About Me")) {
            VStack(alignment: .leading) {
                Image("brent")
                    .resizable()
                    .frame(width: 100, height: 150)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Text("My name is Brent Beamer. I am an iOS Developer, currently building a portfolio of apps that showcase my knowledge of Database Back End, Core Data, Core Animation, SDK’s, UIKit, MVVM, Combine,  API’s, Concurrency, & UI Design. Check out my portfolio for more information about my interests, goals, and projects!")
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundStyle(Color.theme.accent)
            }
            .padding(.vertical)
            Link("Visit My Github →", destination: gitHubURL)
            Link("Visit My Portfolio →", destination: portfolioURL)
        }
    }
    
    private var openBreweryDBSection: some View {
        Section(header: Text("Open Brewery DB")) {
            VStack(alignment: .leading) {
                Image("OpenBreweryDB")
                    .resizable()
                    .frame(width: 150, height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Text("Open Brewery DB is a free dataset and API with public information on breweries, cideries, brewpubs, and bottleshops.")
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundStyle(Color.theme.accent)
            }
            .padding(.vertical)
            Link("Visit Open Brewery DB", destination: openBreweryURL)

        }
    }
    
    private var missouriGuildSection: some View {
        Section(header: Text("Missouri Craft Brewers Guild")) {
            VStack(alignment: .leading) {
                Image("guild")
                    .resizable()
                    .frame(width: 150, height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                
                Text("The Missouri Craft Brewers Guild is a 501(c)(6) nonprofit organization representing more than 100 independent craft breweries in the state of Missouri. Founded in 2011 and incorporated as a non-profit in 2012, the primary focus of the Guild is to advocate for a just and a rational regulatory and statutory environment at the state and federal level and to promote independent craft brewers in the state of Missouri. ")
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundStyle(Color.theme.accent)
            }
            .padding(.vertical)
            Link("Visit Missouri Craft Brewers Guild", destination: missouriGuildURL)

        }
    }
    
    private var applicationSection: some View {
        Section(header: Text("Odds & Ends")) {
            Image("Logo")
                .resizable()
                .frame(width: 100, height: 100)
                .clipShape(RoundedRectangle(cornerRadius: 20))
            Link("Terms of Service", destination: defaultURL)
            Link("Privacy Policy", destination: defaultURL)
            Link("Company Website", destination: defaultURL)
            Link("Learn More", destination: defaultURL)
        }
    }
}
