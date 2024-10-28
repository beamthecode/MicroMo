//
//  PreviewProvider.swift
//  MicroMo
//
//  Created by Brent Beamer on 5/17/24.
//

import Foundation
import SwiftUI

extension PreviewProvider {
    
    static var dev: DeveloperPreview {
        return DeveloperPreview.instance
    }
}

class DeveloperPreview {
    
    static let instance = DeveloperPreview()
    private init() { }
    
    let homeVM = HomeViewModel()
    
    let brewery = Brewery(
        id: "3jfid876dndmdsso",
        name: "Logboat Brewing Company",
        breweryType: "brewpub",
        address1: "504 Fay St",
        address2: nil,
        address3: nil,
        city: "Columbia",
        stateProvince: "Missouri",
        postalCode: "65201",
        country: "United States",
        longitude: "-92.328636",
        latitude: "38.951561",
        phone: "5733976786",
        websiteURL: "https://www.logboatbrewing.com",
        state: "Missouri",
        street: "504 Fay St"
    )
    
    
}

