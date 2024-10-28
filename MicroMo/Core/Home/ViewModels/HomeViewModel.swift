//
//  HomeViewModel.swift
//  MicroMo
//
//  Created by Brent Beamer on 5/18/24.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    
    @Published var allBreweries: [Brewery] = []
    @Published var myBreweries: [Brewery] = []
    @Published var searchText: String = ""
    @Published var sortOption: SortOption = .brewery
    
    private let dataService = BreweryDataService()
    private let myBreweryDataService = MyBreweryDataService()
    private var cancellables = Set<AnyCancellable>()
    
    enum SortOption {
        case brewery, breweryReversed, location, locationReversed
    }
    
    init() {
       addSubscribers()
    }
    
    func addSubscribers() {
        
        // updates allBreweries
        $searchText
            .combineLatest(dataService.$allBreweries, $sortOption)
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map(filterAndSortBreweries)
            .sink { [weak self] (returnedBreweries) in
                self?.allBreweries = returnedBreweries
            }
            .store(in: &cancellables)
        
        // updates MyBreweries
        
        $allBreweries
            .combineLatest(myBreweryDataService.$savedEntities)
            .map(mapAllBreweriesToMyBreweries)
            .sink { [weak self] (returnedBreweries) in
                self?.myBreweries = returnedBreweries
            }
            .store(in: &cancellables)
    }
    
    func updateMyBreweries(brewery: Brewery) {
        myBreweryDataService.updateMyBreweries(brewery: brewery)
    }
    
    private func filterAndSortBreweries(text: String, breweries: [Brewery], sort: SortOption) -> [Brewery] {
        var updatedBreweries = filterBreweries(text: text, breweries: breweries)
        sortBreweries(sort: sort, breweries: &updatedBreweries)
        return updatedBreweries
    }
    
    private func sortBreweries(sort: SortOption, breweries: inout [Brewery]) {
        switch sort {
        case .brewery:
            breweries.sort(by: { $0.name < $1.name })
        case .breweryReversed:
            breweries.sort(by: { $0.name > $1.name })
        case .location:
            breweries.sort(by: { $0.city < $1.city })
        case .locationReversed:
            breweries.sort(by: { $0.city > $1.city })
            
        }
    }
    
    
    private func filterBreweries(text: String, breweries: [Brewery]) -> [Brewery] {
        guard !text.isEmpty else {
            return breweries
        }
        
        let lowercasedText = text.lowercased()
        
        return breweries.filter { (brewery) in
            return brewery.name.lowercased().contains(lowercasedText) || brewery.city.lowercased().contains(lowercasedText)
        }
    }
    
    
    private func mapAllBreweriesToMyBreweries(breweryModels: [Brewery], myBreweryEntities: [MyBreweryEntity]) -> [Brewery] {
        breweryModels
            .compactMap { (brewery) -> Brewery? in
                guard let entity = myBreweryEntities.first(where: { $0.breweryID == brewery.id }) else {
                    return nil
                }
                return brewery
            }
    }
    
}
