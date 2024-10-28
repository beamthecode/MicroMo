//
//  BreweryDetailDataService.swift
//  MicroMo
//
//  Created by Brent Beamer on 5/24/24.
//

import Foundation
import Combine

class BreweryDetailDataService {
    
    @Published var breweryDetails: Brewery? = nil
    
    var breweryDetailSubscription: AnyCancellable?
    let brewery: Brewery
    
    init(brewery: Brewery) {
        self.brewery = brewery
        getBreweryDetails()
        
    }
    
    private func getBreweryDetails() {
        
        guard let url = URL(string: "https://api.openbrewerydb.org/v1/breweries/\(brewery.id)") else { return }
        
        breweryDetailSubscription = NetworkingManager.download(url: url)
            .decode(type: Brewery.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] (returnedBreweryDetails) in
                self?.breweryDetails = returnedBreweryDetails
                self?.breweryDetailSubscription?.cancel()
            })
    
    }
}

// URL(string: "https://api.openbrewerydb.org/v1/breweries?by_state=missouri&by_type=micro&per_page=200")
