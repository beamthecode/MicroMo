//
//  Brewery.swift
//  MicroMo
//
//  Created by Brent Beamer on 5/17/24.
//

import Foundation

    // OpenBreweryDB - AP Info
    /* OpenBreweryDB - my url - pulling Missouri microbreweries and brewpubs
     https://api.openbrewerydb.org/v1/breweries?by_state=missouri&by_type=micro&by_type=brewpub&per_page=200
     https://api.openbrewerydb.org/v1/breweries?by_state=missouri&by_type=micro&per_page=200
     https://api.openbrewerydb.org/v1/breweries?by_state=missouri&per_page=200
     
     JSON Response:
     
     {
           "id": "ef970757-fe42-416f-931d-722451f1f59c",
           "name": "10 Barrel Brewing Co",
           "brewery_type": "large",
           "address_1": "1501 E St",
           "address_2": null,
           "address_3": null,
           "city": "San Diego",
           "state_province": "California",
           "postal_code": "92101-6618",
           "country": "United States",
           "longitude": "-117.129593",
           "latitude": "32.714813",
           "phone": "6195782311",
           "website_url": "http://10barrel.com",
           "state": "California",
           "street": "1501 E St"
       }
     
     */


struct Brewery: Identifiable, Codable {
    let id, name, breweryType, address1: String
    let address2, address3: String?
    let city, stateProvince, postalCode, country: String
    let longitude, latitude, phone: String?
    let websiteURL: String?
    let state, street: String?

    enum CodingKeys: String, CodingKey {
        case id, name
        case breweryType = "brewery_type"
        case address1 = "address_1"
        case address2 = "address_2"
        case address3 = "address_3"
        case city
        case stateProvince = "state_province"
        case postalCode = "postal_code"
        case country, longitude, latitude, phone
        case websiteURL = "website_url"
        case state, street
    }
}
