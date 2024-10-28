//
//  MyBreweryDataService.swift
//  MicroMo
//
//  Created by Brent Beamer on 5/22/24.
//

import Foundation
import CoreData

class MyBreweryDataService {
    
    private let container: NSPersistentContainer
    private let containerName: String = "MyBreweryContainer"
    private let entity: String = "MyBreweryEntity"
    
    @Published var savedEntities: [MyBreweryEntity] = []
    
    init() {
        container = NSPersistentContainer(name: containerName)
        container.loadPersistentStores { _, error in
            if let error = error {
                print("Error loading Core Data! \(error)")
            }
            
            self.getMyBreweries()
        }
    }
    
    // MARK: PUBLIC
    
    func updateMyBreweries(brewery: Brewery) {
        
        // check if brewery is in my list
        if let entity = savedEntities.first(where: { $0.breweryID == brewery.id }) {
            delete(entity: entity)
        } else {
            add(brewery: brewery)
        }
    }
    
    // MARK: PRIVATE
    
    private func getMyBreweries() {
        let request = NSFetchRequest<MyBreweryEntity>(entityName: entity)
        do {
           savedEntities = try container.viewContext.fetch(request)
        } catch let error {
           print("Error fetching My Brewery Entities. \(error)")
        }
    }
    
    private func add(brewery: Brewery) {
        let entity = MyBreweryEntity(context: container.viewContext)
        entity.breweryID = brewery.id
        applyChanges()
    }
    
    private func delete(entity: MyBreweryEntity) {
        container.viewContext.delete(entity)
        applyChanges()
    }
    
    /*
    private func update(entity: MyBreweryEntity) {
        // if additional info is added to app
    }
     */
    
    private func save() {
        do {
            try container.viewContext.save()
        } catch let error {
            print("Error saving to Core Data. \(error)")
        }
    }
    
    private func applyChanges() {
        save()
        getMyBreweries()
    }
    
    
}
