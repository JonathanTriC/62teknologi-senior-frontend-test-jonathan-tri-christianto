//
//  DetailsModel.swift
//  Yelp
//
//  Created by JonathanTriC on 17/06/23.
//

import Foundation

// MARK: - DetailsModel
struct DetailsModel: Codable {
    let id, alias, name: String
    let imageURL: String
    let isClaimed, isClosed: Bool
    let url: String
    let phone, displayPhone: String
    let reviewCount: Int
    let categories: [CategoryDetails]
    let rating: Double
    let location: LocationDetails
    let coordinates: Coordinates
    let photos: [String]
    let price: String
    let hours: [Hour]
    let transactions: [String]

    enum CodingKeys: String, CodingKey {
        case id, alias, name
        case imageURL = "image_url"
        case isClaimed = "is_claimed"
        case isClosed = "is_closed"
        case url, phone
        case displayPhone = "display_phone"
        case reviewCount = "review_count"
        case categories, rating, location, coordinates, photos, price, hours, transactions
    }
}

// MARK: - Category
struct CategoryDetails: Codable {
    let alias, title: String
}

// MARK: - Coordinates
struct Coordinates: Codable {
    let latitude, longitude: Double
}

// MARK: - Hour
struct Hour: Codable {
    let hourOpen: [Open]
    let hoursType: String
    let isOpenNow: Bool

    enum CodingKeys: String, CodingKey {
        case hourOpen = "open"
        case hoursType = "hours_type"
        case isOpenNow = "is_open_now"
    }
}

// MARK: - Open
struct Open: Codable {
    let isOvernight: Bool
    let start, end: String
    let day: Int

    enum CodingKeys: String, CodingKey {
        case isOvernight = "is_overnight"
        case start, end, day
    }
}

// MARK: - Location
struct LocationDetails: Codable {
    let address1: String
    let address2: String?
    let address3: String?
    let city, zipCode, country: String
    let state: String
    let displayAddress: [String]
    let crossStreets: String

    enum CodingKeys: String, CodingKey {
        case address1, address2, address3, city
        case zipCode = "zip_code"
        case country, state
        case displayAddress = "display_address"
        case crossStreets = "cross_streets"
    }
}
