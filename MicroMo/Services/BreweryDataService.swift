//
//  BreweryDataService.swift
//  MicroMo
//
//  Created by Brent Beamer on 5/18/24.
//

import Foundation
import Combine

class BreweryDataService {
    
    @Published var allBreweries: [Brewery] = []
    
    var brewerySubscription: AnyCancellable?
    
    
    init() {
        getBreweries()
        
    }
    
    private func getBreweries() {
        
        guard let url = URL(string: "https://api.openbrewerydb.org/v1/breweries?by_state=missouri&by_type=micro&per_page=200") else { return }
        
        brewerySubscription = NetworkingManager.download(url: url)
            .decode(type: [Brewery].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] (returnedBreweries) in
                self?.allBreweries = returnedBreweries
                self?.brewerySubscription?.cancel()
            })
    
    }
    
    
}
