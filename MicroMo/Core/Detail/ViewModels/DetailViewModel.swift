//
//  DetailViewModel.swift
//  MicroMo
//
//  Created by Brent Beamer on 5/24/24.
//

import Foundation
import Combine

class DetailViewModel: ObservableObject {
    
    @Published var overViewStatistics: [StatsView] = []
    @Published var websiteURL: String? = nil
    
    let brewery: Brewery
    private let breweryDetailService: BreweryDetailDataService
    private var cancellables = Set<AnyCancellable>()
    
    init(brewery: Brewery) {
        self.brewery = brewery
        self.breweryDetailService = BreweryDetailDataService(brewery: brewery)
        self.addSubscribers()
        
    }
    
    
    private func addSubscribers() {
        
        breweryDetailService.$breweryDetails
            .sink { (returnedBreweryDetails) in
                print("Received brewery detail data")
                print(returnedBreweryDetails)
            }
            .store(in: &cancellables)
        
        breweryDetailService.$breweryDetails
            .sink { [weak self] (returnedBreweryDetails) in
                self?.websiteURL = returnedBreweryDetails?.websiteURL
            }
            .store(in: &cancellables)
    }
    
}
